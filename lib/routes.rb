module Pulse
  module Routes
    module Rails2
      def pulse(path)
        connect path, :controller => 'pulse', :action => 'pulse'
      end
    end
    module Rails3
      def pulse(path)
        match path, :controller => 'pulse', :action => 'pulse'
      end
    end
  end
end

if ActionPack::VERSION::MAJOR == 2
  ActionController::Routing::RouteSet::Mapper.send :include, Pulse::Routes::Rails2
elsif ActionPack::VERSION::MAJOR == 3
  ActionDispatch::Routing::Mapper.send :include, Pulse::Routes::Rails3
else
  # teh future
end