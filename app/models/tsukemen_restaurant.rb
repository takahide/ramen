class TsukemenRestaurant < ActiveRecord::Base
  def map_url zoom, size
    "http://maps.google.com/maps/api/staticmap?center=#{self.map}&zoom=#{zoom}&size=#{size}&markers=icon:http://tsuke.men/map_icon.png|#{self.map}&language=ja&sensor=false"
  end

  def station_name
    m = self.station.match(/『(.*)』/)
    m[1] if m.present?
  end

  def station_distance
    m = self.station.match(/（(.*)）/)
    if m.present?
      if m[1].include?("km")
        return "約#{m[1]}"
      elsif m[1].include?("m")
        d_int = m[1].to_i
        d_minute = (d_int - (d_int % 80)) / 80 + 1
        reminder = d_int % 50
        additional = 0
        if reminder > 25
          additional= 50
        end
        d_meter = (d_int - reminder) + additional
        return "約#{d_meter}m（徒歩約#{d_minute}分）"
      end
    end
  end
end
