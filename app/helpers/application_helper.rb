module ApplicationHelper
  def render_breadcrumbs
    crumbs = []
    path_segments = request.path.split("/").reject(&:blank?)

    # Adiciona sempre o link Home
    crumbs << link_to("Home", root_path)

    path_segments.each_with_index do |segment, index|
      name = segment.titleize
      url = "/" + path_segments.first(index + 1).join("/")

      # último item: ativo, sem link
      if index == path_segments.size - 1
        crumbs << content_tag(:span, name, class: "breadcrumb-item active", 'aria-current': "page")
      else
        crumbs << link_to(name, url, class: "breadcrumb-item")
      end
    end

    # Junta tudo dentro da <ol>
    content_tag(:nav, aria: { label: "breadcrumb" }, class: "breadcrumb-header float-start float-lg-end") do
      content_tag(:ol, class: "breadcrumb") do
        crumbs.join.html_safe
      end
    end
  end
end
