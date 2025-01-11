-- vim.cmd [[highlight Headline1 guibg=#101710 guifg=#a3be8c]] -- green
-- vim.cmd [[highlight Headline2 guibg=#151a1e guifg=#81a1c1]] -- blue
-- vim.cmd [[highlight Headline3 guibg=#1c151e guifg=#b48ead]] -- purple
-- vim.cmd [[highlight Headline4 guibg=#201a18 guifg=#d08770]] -- orange
-- vim.cmd [[highlight Headline5 guibg=#211e14 guifg=#ebcb8b]] -- yellow
-- vim.cmd [[highlight Headline6 guibg=#17212b guifg=#bf616a]] -- red
-- vim.cmd [[highlight CodeBlock guibg=#1c1c1c]]
-- vim.cmd [[highlight Dash guibg=#D19A66 gui=bold]]
vim.cmd [[highlight Headline1 guifg=#004d00 gui=bold]] -- dark green text
vim.cmd [[highlight Headline2 guifg=#003366 gui=bold]] -- dark blue text
vim.cmd [[highlight Headline3 guifg=#4b0082 gui=bold]] -- indigo text
vim.cmd [[highlight Headline4 guifg=#8b4513 gui=bold]] -- saddle brown text
vim.cmd [[highlight Headline5 guifg=#806000 gui=bold]] -- dark goldenrod text
vim.cmd [[highlight Headline6 guifg=#800000 gui=bold]] -- maroon text
vim.cmd [[highlight CodeBlock guibg=#f5f5f5 guifg=#000000]] -- very light gray background, black text
vim.cmd [[highlight Dash guifg=#555555 gui=bold]] -- medium gray text with bold
local headlines = {
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = { "markdown" },
    config = true,
    opts = function()
      require("headlines").setup {
        markdown = {
          query = vim.treesitter.query.get(
            "markdown",
            [[
                (atx_heading [
                    (atx_h1_marker)
                    (atx_h2_marker)
                    (atx_h3_marker)
                    (atx_h4_marker)
                    (atx_h5_marker)
                    (atx_h6_marker)
                ] @headline)

                (thematic_break) @dash

                (fenced_code_block) @codeblock

                (block_quote_marker) @quote
                (block_quote (paragraph (inline (block_continuation) @quote)))
                (block_quote (paragraph (block_continuation) @quote))
                (block_quote (block_continuation) @quote)
            ]]
          ),
          headline_highlights = {
            "Headline1",
            "Headline2",
            "Headline3",
            "Headline4",
            "Headline5",
            "Headline6",
          },
          bullet_highlights = {
            "@text.title.1.marker.markdown",
            "@text.title.2.marker.markdown",
            "@text.title.3.marker.markdown",
            "@text.title.4.marker.markdown",
            "@text.title.5.marker.markdown",
            "@text.title.6.marker.markdown",
          },
          bullets = { "◉", "○", "✸", "✿" },
          codeblock_highlight = "CodeBlock",
          dash_highlight = "Dash",
          dash_string = "-",
          quote_highlight = "Quote",
          quote_string = "┃",
          fat_headlines = true,
          fat_headline_upper_string = "▄",
          fat_headline_lower_string = "▀",
        },
        rmd = {
          query = vim.treesitter.query.get(
            "markdown",
            [[
                (atx_heading [
                    (atx_h1_marker)
                    (atx_h2_marker)
                    (atx_h3_marker)
                    (atx_h4_marker)
                    (atx_h5_marker)
                    (atx_h6_marker)
                ] @headline)

                (thematic_break) @dash

                (fenced_code_block) @codeblock

                (block_quote_marker) @quote
                (block_quote (paragraph (inline (block_continuation) @quote)))
                (block_quote (paragraph (block_continuation) @quote))
                (block_quote (block_continuation) @quote)
            ]]
          ),
          treesitter_language = "markdown",
          headline_highlights = { "Headline" },
          bullet_highlights = {
            "@text.title.1.marker.markdown",
            "@text.title.2.marker.markdown",
            "@text.title.3.marker.markdown",
            "@text.title.4.marker.markdown",
            "@text.title.5.marker.markdown",
            "@text.title.6.marker.markdown",
          },
          bullets = { "◉", "○", "✸", "✿" },
          codeblock_highlight = "CodeBlock",
          dash_highlight = "Dash",
          dash_string = "-",
          quote_highlight = "Quote",
          quote_string = "┃",
          fat_headlines = true,
          fat_headline_upper_string = "▄",
          fat_headline_lower_string = "▀",
        },
        norg = {
          query = vim.treesitter.query.get(
            "norg",
            [[
                [
                    (heading1_prefix)
                    (heading2_prefix)
                    (heading3_prefix)
                    (heading4_prefix)
                    (heading5_prefix)
                    (heading6_prefix)
                ] @headline

                (weak_paragraph_delimiter) @dash
                (strong_paragraph_delimiter) @doubledash

                ([(ranged_tag
                    name: (tag_name) @_name
                    (#eq? @_name "code")
                )
                (ranged_verbatim_tag
                    name: (tag_name) @_name
                    (#eq? @_name "code")
                )] @codeblock (#offset! @codeblock 0 0 1 0))

                (quote1_prefix) @quote
            ]]
          ),
          headline_highlights = { "Headline" },
          bullet_highlights = {
            "@neorg.headings.1.prefix",
            "@neorg.headings.2.prefix",
            "@neorg.headings.3.prefix",
            "@neorg.headings.4.prefix",
            "@neorg.headings.5.prefix",
            "@neorg.headings.6.prefix",
          },
          bullets = { "◉", "○", "✸", "✿" },
          codeblock_highlight = "CodeBlock",
          dash_highlight = "Dash",
          dash_string = "-",
          doubledash_highlight = "DoubleDash",
          doubledash_string = "=",
          quote_highlight = "Quote",
          quote_string = "┃",
          fat_headlines = true,
          fat_headline_upper_string = "▄",
          fat_headline_lower_string = "▀",
        },
        org = {
          query = vim.treesitter.query.get(
            "org",
            [[
                (headline (stars) @headline)

                (
                    (expr) @dash
                    (#match? @dash "^-----+$")
                )

                (block
                    name: (expr) @_name
                    (#match? @_name "(SRC|src)")
                ) @codeblock

                (paragraph . (expr) @quote
                    (#eq? @quote ">")
                )
            ]]
          ),
          headline_highlights = { "Headline" },
          bullet_highlights = {
            "@org.headline.level1",
            "@org.headline.level2",
            "@org.headline.level3",
            "@org.headline.level4",
            "@org.headline.level5",
            "@org.headline.level6",
            "@org.headline.level7",
            "@org.headline.level8",
          },
          bullets = { "◉", "○", "✸", "✿" },
          codeblock_highlight = "CodeBlock",
          dash_highlight = "Dash",
          dash_string = "-",
          quote_highlight = "Quote",
          quote_string = "┃",
          fat_headlines = true,
          fat_headline_upper_string = "▄",
          fat_headline_lower_string = "▀",
        },
      }
    end,
  },
}

return headlines
