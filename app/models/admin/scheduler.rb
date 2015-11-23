##
# Model

# Simple Arch design
# Scheduler/
#   events/
#     id
#     name
#     description
#     startTime:datetime
#     endTime:datetime
#     repeat: [daily, weekly]
#     company_id:references
#     createdAt
#     updatedAt
#   posts/


module Admin::Scheduler
  def self.table_name_prefix
    'admin_scheduler_'
  end
end
