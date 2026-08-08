import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

const GATED_TOOLS = new Set(["bash", "edit", "write"]);

function summarizeToolCall(toolName: string, input: unknown): string {
  const value = input as Record<string, unknown> | undefined;

  if (toolName === "bash") {
    return String(value?.command ?? "");
  }

  if (toolName === "edit" || toolName === "write") {
    const path = String(value?.path ?? "(unknown path)");
    return `path: ${path}`;
  }

  return JSON.stringify(input, null, 2);
}

export default function (pi: ExtensionAPI) {
  pi.on("tool_call", async (event, ctx) => {
    if (!GATED_TOOLS.has(event.toolName)) return;

    const action = event.toolName === "bash" ? "run this command" : "edit this file";
    const summary = summarizeToolCall(event.toolName, event.input);

    if (!ctx.hasUI) {
      return {
        block: true,
        reason: `Permission required to ${action}, but no interactive UI is available.`,
      };
    }

    const ok = await ctx.ui.confirm(
      `Allow ${event.toolName}?`,
      `Pi wants to ${action}:\n\n${summary}`,
    );

    if (!ok) {
      return { block: true, reason: `User denied permission to ${action}.` };
    }
  });

  pi.on("user_bash", async (event, ctx) => {
    if (!ctx.hasUI) {
      return {
        result: {
          output: "Permission required to run a user bash command, but no interactive UI is available.",
          exitCode: 1,
          cancelled: false,
          truncated: false,
        },
      };
    }

    const ok = await ctx.ui.confirm(
      "Allow user bash command?",
      `Run this command?\n\n${event.command}`,
    );

    if (!ok) {
      return {
        result: {
          output: "User denied permission to run command.",
          exitCode: 1,
          cancelled: false,
          truncated: false,
        },
      };
    }
  });
}
