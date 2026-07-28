module VersionSortFilter
  def sort_by_version(items, key)
    items.sort_by do |item|
      raw = item[key].to_s
      cleaned = raw.sub(/\Av/i, "") # strip leading "v"
      begin
        Gem::Version.new(cleaned)
      rescue ArgumentError
        Gem::Version.new("0")
      end
    end
  end
end

Liquid::Template.register_filter(VersionSortFilter)
