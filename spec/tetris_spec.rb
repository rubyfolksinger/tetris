require 'spec_helper'

describe 'Tetris' do
  it 'should have a version' do
    Tetris::VERSION.class.should == String
  end

  it 'should exist' do
    Tetris.class.should == Module
  end
end