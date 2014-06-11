module CommandLine
  module IO
    def self.solicit_input
      gets.chomp
    end

    def self.display(message)
      puts message
    end

    def self.display_red(message)
      puts red(message)
    end

    def self.red(message)
      colorize(message, 31)
    end

    def self.blue(message)
      colorize(message, 34)
    end

    def self.colorize(message, color_code)
      "\e[#{color_code}m#{message}\e[0m"
    end
  end
end
