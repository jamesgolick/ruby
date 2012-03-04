module TCS

module HilightHelper

  def hilight(lang, &block)
    <<-HTML
<pre><code class='language-#{lang}'>#{h(&block)}</code></pre>
    HTML
  end

end

end
