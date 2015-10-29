module ApplicationHelper


  def self.params_constructions_jobs(params)
    str = ''
    params.each do |key, value|
      if key!="action" && key!="controller" && key!="id" && key != 'authenticity_token' && key != '_method' && key != 'jprofile_id' && key != 'comment'
        str+=key.to_s+'='+value+'&'
      end
    end

    return str
  end


  def self.params_constructions_jprofile(params)
    str = ''
    params.each do |key, value|
      if key!="action" && key!="controller" && key!="id" && key != 'authenticity_token' && key != '_method' && key != 'jprofile_id'
        str+='&'+key.to_s+'='+value
      end
    end

    return str
  end


end
