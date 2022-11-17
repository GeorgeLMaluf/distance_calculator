# frozen_string_literal: true

class DistanceCalculator
  attr_accessor :coords

  def initialize(coordenadas)
    @coords = coordenadas
  end

  def solvable?
    @coords.length >= 2
  end

  def calculate
    distances = []

    @coords.each_with_index do |coord1, i|
      @coords.each_with_index do |coord2, j|
        next if i == j

        result = distance(coord1, coord2)
        distances.push("A distância entre os Pontos #{i + 1} e #{j + 1}: #{result.round(2)} kms")
      end
    end

    distances
  end

  private

  def distance(cd1, cd2)
    rad_per_deg = Math::PI / 180
    rkm = 6371

    dlat_rad = (cd2[0]-cd1[0]) * rad_per_deg
    dlon_rad = (cd2[1]-cd1[1]) * rad_per_deg

    lat1_rad = cd1.map { |i| i * rad_per_deg }.first
    lat2_rad = cd2.map { |i| i * rad_per_deg }.first

    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

    rkm * c
  end
end
