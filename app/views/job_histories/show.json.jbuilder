#json.extract! @job_history, :id, :year_of_experience, :current_job_title, :salary_type_id, :salary_id, :jproifle_id, :created_at, :updated_at

json.extract! @job_history, :id,:title,:organization,:from, :to