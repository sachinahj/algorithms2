require_relative '../merge_sort.rb'
require 'rubygems'
require 'rspec'

describe 'MergeSort' do
  describe '.selection_sort' do

    context 'when the argument is empty' do
      it "returns an empty array" do
        expect(MergeSort.sort([])).to eq([])
      end
    end

    context 'when the argument has negative numbers' do
      it "sorts the array properly" do
        array = [-2, -1, -3, 5, -7 ,-10]
        expect(MergeSort.sort(array)).to eq(array.sort)
      end
    end

    context 'when the argument has duplicate numbers' do
      it "sorts the array properly" do
        array = [5, 1, 10, 5, 7 ,3, 10]
        expect(MergeSort.sort(array)).to eq(array.sort)
      end
    end

    context 'when the argument is large unordered array' do
      it "sorts the array properly" do
        array = [123,23,65,8,3,7,4,8,54,3,6567,89,542,45,7,45,2,34,6,67,83,45,23,446,67,76,3]
        expect(MergeSort.sort(array)).to eq(array.sort)
      end
    end

    context 'when the argument is a size one' do
      it "returns the array with one value" do
        array = [9]
        expect(MergeSort.sort(array)).to eq(array.sort)
      end
    end

    context 'when the argument melody of negatives, positives and zeros' do
      it "sorts the array properly" do
        array = [3 ,5, -6, 4, -7, 1, 2, 0, -12, 13]
        expect(MergeSort.sort(array)).to eq(array.sort)
      end
    end

  end
end