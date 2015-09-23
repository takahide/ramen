class ListScraper < Scraper

  def initialize prefecture, code, area_min, area_max
    @prefecture = prefecture
    @code = code
    @area_min = area_min
    @area_max = area_max
    @page_max = 60
    @urls = []
    @areas = []
    @pages = []
    @area_index = 0
    @page_index = 0
    for area in area_min..area_max
      for page in 1..@page_max
        @urls.push "http://tabelog.com/tokyo/#{code}#{area}/rstLst/ramen/#{page}/"
        @areas.push area
        @pages.push page
      end
    end
  end

  def get_next_page
    index = @area_index * @page_max + @page_index
    @html = access(@urls[index]).to_s
    if @html.include? "ご指定の条件に該当するお店は見つかりませんでした。"
      @html = nil
      if @area_index == @area_max - @area_min
        return 2
      else
        @area_index += 1
        @page_index = 0
        return 1
      end
    else
      @page_index += 1
      return 0
    end
  end

  def prefecture
    @prefecture
  end

  def area
    index = @area_index + @page_index
    "#{@code}#{@areas[index]}"
  end

  def page
    index = @area_index + @page_index
    @pages[index]
  end

  def html
    @html
  end
end
