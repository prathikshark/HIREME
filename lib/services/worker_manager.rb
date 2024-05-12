module Services
    class WorkerManager

        def initialize(params,filter_params)
            @params = params
            @filter_params = filter_params
          end
      
        def filter_workers
            Services::Workers::FilterWorker.new(@params,@filter_params).call
        end

    end
end