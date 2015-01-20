require_relative '../lib/conway'

RSpec.describe Cell do
  describe '#initialize' do
    context 'optionally takes a status argument to initialize it, defaults dead' do
      it 'is initialized alive' do
        cell = Cell.new(status: :alive)
        expect(cell).to be_a Cell
        expect(cell.status).to be :alive
      end

       it 'is initialized dead' do
        cell = Cell.new()
        expect(cell).to be_a Cell
        expect(cell.status).to be :dead
      end
    end
  end

  describe '#survive' do
    subject(:alive_cell) { Cell.new(status: :alive) }
    subject(:dead_cell) { Cell.new }
    context 'alive cell with fewer than two alive neighbors' do
      it 'will return a new dead cell' do
        expect(alive_cell.survive(alive_neighbors: 0)).to eq dead_cell
        expect(alive_cell.survive(alive_neighbors: 1)).to eq dead_cell
      end
    end

    context 'alive cell with more than 3 live neighbors' do
      it 'will return a new dead cell' do
        expect(alive_cell.survive(alive_neighbors: 4)).to eq dead_cell
      end
    end

    context 'alive cell with 2 or 3 live neighbors' do
      it 'will return a new alive cell' do
        expect(alive_cell.survive(alive_neighbors: 2)).to eq alive_cell
        expect(alive_cell.survive(alive_neighbors: 3)).to eq alive_cell
      end
    end

    context 'dead cell without 3 live neighbors' do
      it 'stays dead' do
        expect(dead_cell.survive(alive_neighbors: 2)).to eq dead_cell
        expect(dead_cell.survive(alive_neighbors: 4)).to eq dead_cell
      end
    end

    context 'dead cell with 3 live neighbors' do
      it 'will return a new alive cell' do
        expect(dead_cell.survive(alive_neighbors: 3)).to eq alive_cell
      end
    end
  end
end

RSpec.describe World do

  describe '#initialize' do
    subject(:world) { World.new(dimensions: 20) }
    subject(:seed_cells) { [
                            [Cell.new(status: :alive),Cell.new(status: :alive),Cell.new(status: :dead)],
                            [Cell.new(status: :alive),Cell.new(status: :dead),Cell.new(status: :alive)],
                            [Cell.new(status: :dead),Cell.new(status: :dead),Cell.new(status: :dead)]] }
    it 'creates a world' do
      expect(world).to be_a World
    end
    it 'generates a 2d grid' do
      expect(world.cells).to be_an Array
      expect(world.cells.first).to be_an Array
    end
    it 'optionally takes dimensions, defaults to 64x64 for dimensions' do
      expect(World.new).to be_a World
    end
    it 'optionally takes an array of a new world' do
      expect(World.new(cells: seed_cells)).to be_a World
    end
  end

  describe '#next_world' do
    subject(:seed_cells) { [
                            [Cell.new(status: :alive),Cell.new(status: :alive),Cell.new(status: :dead)],
                            [Cell.new(status: :alive),Cell.new(status: :dead),Cell.new(status: :alive)],
                            [Cell.new(status: :dead),Cell.new(status: :dead),Cell.new(status: :dead)]] }
    subject(:result_cells) { [
                            [Cell.new(status: :alive),Cell.new(status: :alive),Cell.new(status: :dead)],
                            [Cell.new(status: :alive),Cell.new(status: :dead),Cell.new(status: :dead)],
                            [Cell.new(status: :dead),Cell.new(status: :dead),Cell.new(status: :dead)]] }
    subject(:world) { World.new(cells: seed_cells) }
    it 'generates the next world' do
      expect(world.next_world).to be_a World
      expect(world.next_world.cells).to eq result_cells
    end
  end
end
