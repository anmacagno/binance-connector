# frozen_string_literal: true

module FileHelpers
  def file_fixture(path)
    File.read(File.join('spec', 'fixtures', path))
  end
end
