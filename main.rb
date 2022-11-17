# frozen_string_literal: true
require 'io/console'
require_relative './lib/distance_calculator'

class DistanceMain
  attr_accessor :coordenadas, :opcao

  def initialize
    @coordenadas = []
    @opcao = 1
  end

  def main
    show_info
    while @opcao == 1
      show_menu
      show_add_coordenada if @opcao == 1
    end

    if @opcao == 2
      dc = DistanceCalculator.new(@coordenadas)
      if dc.solvable?
        puts dc.calculate
      else
        puts 'Número de coordenadas insuficientes para calcular distâncias'
      end
    end
  end

  private

  def show_info
    puts 'Calculo de distancias entre coordenadas geográficas'
    puts "George L. 'Maverick' Maluf"
    3.times { puts '' }
  end

  def show_menu
    puts "Número coordenadas: #{@coordenadas.length}"
    puts '1 - Para adicionar coordenadas'
    puts '2 - Para calcular distancias'
    puts 'Qual a sua opção:'
    @opcao = gets.to_i
  end

  def show_add_coordenada
    coordenada = []
    puts 'Digite a latitude:'
    latitude = gets.to_f
    coordenada.push(latitude)
    puts 'Digite a longitude:'
    longitude = gets.to_f
    coordenada.push(longitude)

    @coordenadas.push(coordenada)
    $stdout.clear_screen
    puts 'Coordenada adicionada.'
  end
end

DistanceMain.new.main
