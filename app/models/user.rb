class User < ActiveRecord::Base
  serialize :responses
  serialize :matchedWith
  serialize :matchHistory

  def self.from_omniauth(auth)
  #Updates/ creates user object in database
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)

      # Check to see if this is the first time this user is logging in to the site.
      if User.find( :all, :conditions => ["uid = ? ", user.uid] ).length == 0
        user.matched = false
        user.responses = [ rand(0..5), rand(0..5), rand(0..5), rand(0..5), rand(0..5) ]
        user.matchedWith = Set.new
        user.matchedWith.add( user.uid )
      end

      user.generateRelationships()
      user.assignMatch()
      #user.matchHistory.add( user.uid )
      user.save!
    end
  end

  def getCompatibility( u2 )
    score = 0

    for i in ( 0 ... 5 )
      score += ( responses[i].to_i - u2.responses[i].to_i ).abs
    end
    
    return score
  end

  def generateRelationships()
    for person in User.find( :all, :conditions => ["uid != ? ", uid] )
      if ( not ( matchedWith.include?( person.uid ) ) )
        r = Relationship.new
        r.uid1 = uid
        r.uid2 = person.uid
        r.weight = getCompatibility( person )
        matchedWith.add( person.uid )
        r.save!
      end
    end
  end

  def assignMatch()
    for relationship in Relationship.find( :all, :conditions => [ "uid1=? ", uid ], :order => "weight ASC" )
      @u = User.find( :first, :conditions => ["uid=? ", relationship.uid2 ] )
      if ( @u.matched == "f" )
        m = Meetup.new
        m.uid1 = uid
        m.uid2 = @u.uid
        m.expires_at = 3.days.from_now
        m.save!
        matched = true
        save!
        @u.matched = true
        @u.save!
        return
      end
    end
  end
end
