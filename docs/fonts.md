# Fonts

[Nerd Fonts](https://www.nerdfonts.com/font-downloads)
are a collection of popular developer-focused fonts, _patched with a massive set of additional glyphs and icons._ They merge standard monospaced typefaces with symbols from sets like Font Awesome, Devicons, and Octicons. Why they excel for developer workstations:

- Modern shell prompts: They are required by popular prompt engines like Oh My Posh and Starship, et. al. to display visual indicators for Git status, environment info, and directory types instead of broken Unicode boxes.
- Enhanced terminals: Tools like lsd and colorls use these icons to provide instant visual cues for file types (e.g., a Python logo next to .py files), making navigation significantly faster.
- Consistent aesthetics: They provide a unified look across your entire workflow, ensuring symbols look the same in your terminal, editor, and system UI.

Some good nerd fonts (from v3.4.0) for terminal displays include

- `FiraCode` ([Fira Type](https://carrois.com/fira/))
- `JetBrainsMono` ([JetBrains Mono](https://www.jetbrains.com/lp/mono/))
- `IBMPlexMono` ([IBM Plex](https://www.ibm.com/plex/))

## Font Config

[Fontconfig](https://www.freedesktop.org/wiki/Software/fontconfig/) is the Linux library for configuring & customizing font access

- 📖 [Fontconfig user manpage](https://www.freedesktop.org/software/fontconfig/fontconfig-user.html)

### Some Usage Tips

- Find the Exact Name for Your Config: Use this to find the specific string needed for your terminal or editor settings (e.g., JetBrainsMono Nerd Font or JetBrainsMono NF or wat): `fc-list : family | grep -i "JetBrains"`
- Verify Monospace Compatibility: Terminals often only show fonts explicitly marked as monospaced. This command filters for fonts with spacing=100 (the code for monospace): `fc-list :spacing=100 family | grep -i "JetBrains"`
- Identify Styles (Bold, Italic, Light): If you want to see which specific weights are available (e.g., ExtraBold, Thin, Medium): `fc-list : family style | grep -i "JetBrains"`
- Locate the Actual Font Files: If you need to know where the .ttf or .otf files are stored on your system to verify the installation: `fc-list : file family | grep -i "JetBrains"`
- Advanced: Custom Formatted List: Create a clean, tab-separated list of all JetBrains Mono variations with their style and file path: `fc-list --format="%{family}\t%{style}\t%{file}\n" | grep -i "JetBrains"`
