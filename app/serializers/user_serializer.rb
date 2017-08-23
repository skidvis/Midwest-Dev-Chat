class UserSerializer < ActiveModel::Serializer
  attributes :fullname, :slackhandle, :career_status, :location, :max_distance, :will_relocate, :will_remote, :preferred_languages, :resume, :linkedin, :github 
end
