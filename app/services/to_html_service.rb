class ToHTMLService
  def self.perform(markdown_or_plaintext)
    result = pipeline.call markdown_or_plaintext
    result[:output].to_s.html_safe
  end

  def self.pipeline(options = {})
    HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::SanitizationFilter,
      HTML::Pipeline::ImageMaxWidthFilter,
      HTML::Pipeline::EmojiFilter,
      HTML::Pipeline::RougeFilter,
    ], options.merge(context)
  end

  def self.context
    {
      asset_root:   "http://localhost:3000/images",
      base_url:     "http://localhost:3000",
      gfm:          true,
      line_numbers: false,
    }
  end
end
