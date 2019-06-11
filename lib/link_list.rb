module LinkList
  extend self

  def links
    @links ||= {}
  end

  def find(link)
    external_link = links[link]
    external_link ? external_link : links.key(link)
  end

  def delete_all
    @links = {}
  end
end
