# frozen_string_literal: true

require_relative '../../lib/distance_calculator'

RSpec.describe DistanceCalculator do
  describe '#solvable?' do
    context 'quando tem somente 1 coordenada' do
      let(:subject) do
        DistanceCalculator.new([[-26.2218, -51.1210]]) # UniaoDaVitoria
      end

      it 'esperado FALSE' do
        expect(subject.solvable?).to be_falsey
      end
    end
    context 'quando tem ao menos 2 coordenadas' do
      let(:subject) do
        DistanceCalculator.new([[-26.2218, -51.1210], # UniaoDaVitoria
                                [ -31.776, -52.3594]])   # Pelotas
      end
      it 'esperado TRUE' do
        expect(subject.solvable?).to be_truthy
      end
    end
  end

  describe 'calculate' do
    context 'quando tem 2 coordenadas' do
      let(:response) do
        ['A distância entre os Pontos 1 e 2: 629.22 kms',
         'A distância entre os Pontos 2 e 1: 629.22 kms']
      end

      let(:subject) do
        DistanceCalculator.new([[-26.2218, -51.1210], # UniaoDaVitoria
                                [-31.776, -52.3594]]) # Pelotas
      end

      it 'experado 2 respostas' do
        distancias = subject.calculate
        aggregate_failures do
          expect(distancias.length).to eq(2)
          expect(distancias[0]).to eq(response[0])
          expect(distancias[1]).to eq(response[1])
        end
      end
    end

    context 'quando tem 3 coordenadas' do
      let(:response) do
        ['A distância entre os Pontos 1 e 2: 629.22 kms',
         'A distância entre os Pontos 1 e 3: 204.9 kms',
         'A distância entre os Pontos 2 e 1: 629.22 kms',
         'A distância entre os Pontos 2 e 3: 767.32 kms',
         'A distância entre os Pontos 3 e 1: 204.9 kms',
         'A distância entre os Pontos 3 e 2: 767.32 kms']
      end

      let(:subject) do
        DistanceCalculator.new([[-26.2218, -51.1210], # UniaoDaVitoria
                                [-31.776, -52.3594],  # Pelotas
                                [-25.4284, -49.2733]]) # Curitiba
      end

      it 'experado 6 respostas' do
        distancias = subject.calculate
        expect(distancias.length).to eq(6)
        expect(distancias[0]).to eq(response[0])
        expect(distancias[1]).to eq(response[1])
        expect(distancias[2]).to eq(response[2])
        expect(distancias[3]).to eq(response[3])
        expect(distancias[4]).to eq(response[4])
        expect(distancias[5]).to eq(response[5])
      end
    end
  end
end
