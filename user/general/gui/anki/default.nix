{ lib, config, pkgs, ... }:
let
  cfg = config.anki;
in
{
  options.anki = {
    enable = lib.mkEnableOption "anki";
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (anki.withAddons [
       ankiAddons.passfail2
       (anki-utils.buildAnkiAddon (finalAttrs: {
                                   pname = "MoreOverviewStats";
                                   version = "v2.1.36";
                                   src = fetchFromGitHub {
                                   owner = "patrick-mahnkopf";
                                   repo = "Anki_More_Overview_Stats";
                                   rev = "v2.1.36";
                                   sha256 = "Mt6EqFmQChgOf7Y/JufFoL/fgpl5yBoqiyULlAbLqrE=";
                                   };}))
       (anki-utils.buildAnkiAddon (finalAttrs: {
                                   pname = "ProgressStats";
                                   version = "v0.13";
                                   src = fetchFromGitHub {
                                   owner = "matthayes";
                                   repo = "anki_progress_stats";
                                   rev = "v0.13";
                                   sha256 = "KR9DUTUQ5U++WCgCvPK89/BP60KMnxmzKXCUIFEMkqo=";
                                   };}))
#     owner = "AnKing-VIP";
#     repo = "advanced-broswer";
       ])
# (ankiAddons.recolor.withConfig {
#   config = {
#     version = {
#       major = 3;
#       minor = 1;
#     };
#     colors = {
#       ACCENT_CARD = [
#         "Card mode"
#           config.stylix.base16Scheme.base0D
#           config.stylix.base16Scheme.base0D
#           "--accent-card"
#       ];
#       ACCENT_DANGER = [
#         "Danger"
#           config.stylix.base16Scheme.base08
#           config.stylix.base16Scheme.base08
#           "--accent-danger"
#       ];
#       ACCENT_NOTE = [
#         "Note mode"
#           config.stylix.base16Scheme.base0B
#           config.stylix.base16Scheme.base0B
#           "--accent-note"
#       ];
#       BORDER = [
#         "Border"
#           config.stylix.base16Scheme.base04
#           config.stylix.base16Scheme.base04
#           "--border"
#       ];
#       BORDER_FOCUS = [
#         "Border (focused input)"
#           config.stylix.base16Scheme.base0D
#           config.stylix.base16Scheme.base0D
#           "--border-focus"
#       ];
#       BORDER_STRONG = [
#         "Border (strong)"
#           config.stylix.base16Scheme.base03
#           config.stylix.base16Scheme.base03
#           "--border-strong"
#       ];
#       BORDER_SUBTLE = [
#         "Border (subtle)"
#           config.stylix.base16Scheme.base07
#           config.stylix.base16Scheme.base07
#           "--border-subtle"
#       ];
#       BUTTON_BG = [
#         "Button background"
#           config.stylix.base16Scheme.base01
#           config.stylix.base16Scheme.base01
#           "--button-bg"
#       ];
#       BUTTON_DISABLED = [
#         "Button background (disabled)"
#           "${config.stylix.base16Scheme.base01}80"
#           "${config.stylix.base16Scheme.base01}80"
#           "--button-disabled"
#       ];
#       BUTTON_HOVER = [
#         "Button background (hover)"
#           config.stylix.base16Scheme.base02
#           config.stylix.base16Scheme.base02
#           [
#           "--button-gradient-start"
#             "--button-gradient-end"
#           ]
#       ];
#       BUTTON_HOVER_BORDER = [
#         "Button border (hover)"
#           config.stylix.base16Scheme.base01
#           config.stylix.base16Scheme.base01
#           "--button-hover-border"
#       ];
#       BUTTON_PRIMARY_BG = [
#         "Button Primary Bg"
#           config.stylix.base16Scheme.base0D
#           config.stylix.base16Scheme.base0D
#           "--button-primary-bg"
#       ];
#       BUTTON_PRIMARY_DISABLED = [
#         "Button Primary Disabled"
#           "${config.stylix.base16Scheme.base0D}80"
#           "${config.stylix.base16Scheme.base0D}80"
#           "--button-primary-disabled"
#       ];
#       BUTTON_PRIMARY_GRADIENT_END = [
#         "Button Primary Gradient End"
#           config.stylix.base16Scheme.base0D
#           config.stylix.base16Scheme.base0D
#           "--button-primary-gradient-end"
#       ];
#       BUTTON_PRIMARY_GRADIENT_START = [
#         "Button Primary Gradient Start"
#           config.stylix.base16Scheme.base0D
#           config.stylix.base16Scheme.base0D
#           "--button-primary-gradient-start"
#       ];
#       CANVAS = [
#         "Background"
#           config.stylix.base16Scheme.base00
#           config.stylix.base16Scheme.base00
#           [
#           "--canvas"
#             "--bs-body-bg"
#           ]
#       ];
#       CANVAS_CODE = [
#         "Code editor background"
#           config.stylix.base16Scheme.base00
#           config.stylix.base16Scheme.base00
#           "--canvas-code"
#       ];
#       CANVAS_ELEVATED = [
#         "Background (elevated)"
#           config.stylix.base16Scheme.base01
#           config.stylix.base16Scheme.base01
#           "--canvas-elevated"
#       ];
#       CANVAS_GLASS = [
#         "Background (transparent text surface)"
#           "${config.stylix.base16Scheme.base01}66"
#           "${config.stylix.base16Scheme.base01}66"
#           "--canvas-glass"
#       ];
#       CANVAS_INSET = [
#         "Background (inset)"
#           config.stylix.base16Scheme.base01
#           config.stylix.base16Scheme.base01
#           "--canvas-inset"
#       ];
#       CANVAS_OVERLAY = [
#         "Background (menu & tooltip)"
#           config.stylix.base16Scheme.base02
#           config.stylix.base16Scheme.base02
#           "--canvas-overlay"
#       ];
#       FG = [
#         "Text"
#           config.stylix.base16Scheme.base05
#           config.stylix.base16Scheme.base05
#           [
#           "--fg"
#             "--bs-body-color"
#           ]
#       ];
#       FG_DISABLED = [
#         "Text (disabled)"
#           config.stylix.base16Scheme.base03
#           config.stylix.base16Scheme.base03
#           "--fg-disabled"
#       ];
#       FG_FAINT = [
#         "Text (faint)"
#           config.stylix.base16Scheme.base04
#           config.stylix.base16Scheme.base04
#           "--fg-faint"
#       ];
#       FG_LINK = [
#         "Text (link)"
#           config.stylix.base16Scheme.base0D
#           config.stylix.base16Scheme.base0D
#           "--fg-link"
#       ];
#       FG_SUBTLE = [
#         "Text (subtle)"
#           config.stylix.base16Scheme.base03
#           config.stylix.base16Scheme.base03
#           "--fg-subtle"
#       ];
#
#       FLAG_1 = [
#         "Flag 1"
#           config.stylix.base16Scheme.base08
#           config.stylix.base16Scheme.base08
#           "--flag-1"
#       ];
#       FLAG_2 = [
#         "Flag 2"
#           config.stylix.base16Scheme.base09
#           config.stylix.base16Scheme.base09
#           "--flag-2"
#       ];
#       FLAG_3 = [
#         "Flag 3"
#           config.stylix.base16Scheme.base0A
#           config.stylix.base16Scheme.base0A
#           "--flag-3"
#       ];
#       FLAG_4 = [
#         "Flag 4"
#           config.stylix.base16Scheme.base0B
#           config.stylix.base16Scheme.base0B
#           "--flag-4"
#       ];
#       FLAG_5 = [
#         "Flag 5"
#           config.stylix.base16Scheme.base0C
#           config.stylix.base16Scheme.base0C
#           "--flag-5"
#       ];
#       FLAG_6 = [
#         "Flag 6"
#           config.stylix.base16Scheme.base0D
#           config.stylix.base16Scheme.base0D
#           "--flag-6"
#       ];
#       FLAG_7 = [
#         "Flag 7"
#           config.stylix.base16Scheme.base0E
#           config.stylix.base16Scheme.base0E
#           "--flag-7"
#       ];
#
#       HIGHLIGHT_BG = [
#         "Highlight background"
#           "${config.stylix.base16Scheme.base02}80"
#           "${config.stylix.base16Scheme.base02}80"
#           "--highlight-bg"
#       ];
#       HIGHLIGHT_FG = [
#         "Highlight text"
#           config.stylix.base16Scheme.base05
#           config.stylix.base16Scheme.base05
#           "--highlight-fg"
#       ];
#       SCROLLBAR_BG = [
#         "Scrollbar background"
#           config.stylix.base16Scheme.base03
#           config.stylix.base16Scheme.base03
#           "--scrollbar-bg"
#       ];
#       SCROLLBAR_BG_ACTIVE = [
#         "Scrollbar background (active)"
#           config.stylix.base16Scheme.base06
#           config.stylix.base16Scheme.base06
#           "--scrollbar-bg-active"
#       ];
#       SCROLLBAR_BG_HOVER = [
#         "Scrollbar background (hover)"
#           config.stylix.base16Scheme.base07
#           config.stylix.base16Scheme.base07
#           "--scrollbar-bg-hover"
#       ];
#       SELECTED_BG = [
#         "Selected Bg"
#           config.stylix.base16Scheme.base02
#           config.stylix.base16Scheme.base02
#           "--selected-bg"
#       ];
#       SELECTED_FG = [
#         "Selected Fg"
#           config.stylix.base16Scheme.base05
#           config.stylix.base16Scheme.base05
#           "--selected-fg"
#       ];
#       SHADOW = [
#         "Shadow"
#           config.stylix.base16Scheme.base01
#           config.stylix.base16Scheme.base01
#           "--shadow"
#       ];
#       SHADOW_FOCUS = [
#         "Shadow (focused input)"
#           config.stylix.base16Scheme.base0D
#           config.stylix.base16Scheme.base0D
#           "--shadow-focus"
#       ];
#       SHADOW_INSET = [
#         "Shadow (inset)"
#           config.stylix.base16Scheme.base01
#           config.stylix.base16Scheme.base01
#           "--shadow-inset"
#       ];
#       SHADOW_SUBTLE = [
#         "Shadow (subtle)"
#           config.stylix.base16Scheme.base01
#           config.stylix.base16Scheme.base01
#           "--shadow-subtle"
#       ];
#       STATE_BURIED = [
#         "Buried"
#           config.stylix.base16Scheme.base09
#           config.stylix.base16Scheme.base09
#           "--state-buried"
#       ];
#       STATE_LEARN = [
#         "Learn"
#           config.stylix.base16Scheme.base08
#           config.stylix.base16Scheme.base08
#           "--state-learn"
#       ];
#       STATE_MARKED = [
#         "Marked"
#           config.stylix.base16Scheme.base0E
#           config.stylix.base16Scheme.base0E
#           "--state-marked"
#       ];
#       STATE_NEW = [
#         "New"
#           config.stylix.base16Scheme.base0D
#           config.stylix.base16Scheme.base0D
#           "--state-new"
#       ];
#       STATE_REVIEW = [
#         "Review"
#           config.stylix.base16Scheme.base0B
#           config.stylix.base16Scheme.base0B
#           "--state-review"
#       ];
#       STATE_SUSPENDED = [
#         "Suspended"
#           config.stylix.base16Scheme.base0A
#           config.stylix.base16Scheme.base0A
#           "--state-suspended"
#       ];
#     };
#   };
# })
         ];
  };
}
