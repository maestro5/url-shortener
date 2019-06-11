class LinkCreator
  attr_reader :url, :errors, :internal_link

  def self.call(*args)
    new(*args).tap(&:perform)
  end

  def initialize(options = {})
    @url    = options[:url]
    @errors = []
  end

  def perform
    internal_link if url_valid? && add_scheme! && save_url
  end

  def success?
    errors.empty?
  end

  private

  def url_valid?
    errors << 'Fill an url and try again.' and return false unless url

    begin
      uri = URI.parse(url)
    rescue
      errors << 'This is not an URL.' and return false
    end

    true
  end

  def add_scheme!
    return true if url_has_scheme?

    @url = "http://#{url}"

    url_has_scheme?
  end

  def url_has_scheme?
    !!(url =~ URI::regexp(%w(http https)))
  end

  def save_url
    @internal_link = existing_internal_link and return true if existing_internal_link

    @internal_link = new_internal_link

    link_list.links[internal_link] = url
  end

  def existing_internal_link
    @existing_internal_link ||= link_list.find(url)
  end

  def new_internal_link
    new_link = nil

    until new_link
      new_link = "#{random_string}#{random_number}" unless link_list.links.keys.include?(new_link)
    end

    new_link
  end

  def random_string
    Array('a'..'z').sample(3).join()
  end

  def random_number
    rand 100..101
  end

  def link_list
    @link_list ||= LinkList
  end
end
