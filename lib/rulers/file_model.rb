require 'multi_json'

module Rulers
  module Model
    class FileModel
      @models = {}

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

      def save
        File.open("db/quotes/#{ @id }.json", "w") do |file|
          file.write MultiJson.dump(@hash)
        end
      end

      def self.find_by_submitter(name)
        self.find_all.find do |model|
          model[:submitter] == name
        end
      end

      def self.find(id)
        begin
          if @models.keys.include? id
            @models[id]
          else
            FileModel.new("db/quotes/#{id}.json").tap do |model|
              @models[id] = model
            end
          end
        rescue => e
          puts e.inspect
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

        ids = model_filenames.map { |n| File.split(n)[-1].to_i }
        new_id = ids.max + 1

        File.open("db/quotes/#{ new_id }.json", "w") do |file|
          file.write MultiJson.dump(attributes)
        end

        self.find(new_id)
      end
    end
  end
end
