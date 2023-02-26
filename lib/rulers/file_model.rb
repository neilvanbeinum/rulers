require 'multi_json'

module Rulers
  module Model
    class FileModel
      def initialize(filename)
        @filename = filename

        basename = File.split(filename)[-1]
        @id = File.basename(basename, '.json').to_i

        obj = File.read(filename)
        @hash = MultiJson.load(obj)
      end

      def [](name)
        @hash[name.to_s]
      end

      def []=(name, value)
        @hash[name.to_s] = value
      end

      def self.find(id)
        begin
          FileModel.new("db/quotes/#{id}.json")
        rescue
          return nil
        end
      end

      def self.find_all
        quote_files = Dir.glob("db/quotes/*.json")

        quote_files.map do |file|
          FileModel.new(file)
        end
      end

      def self.create(attributes = {})
        model_filenames = Dir.glob("db/quotes/*.json")

        File.open("db/quotes/#{ model_filenames.length + 1 }.json", "w") do |file|
          file.write MultiJson.dump(attributes)
        end
      end
    end
  end
end
