def done( task = "", status = true )
  status
end

describe "Authlogic installation" do
  it "put gem in Gemfile and bundle" do
    done
  end

  it "models: User, UserSession" do
    done
  end

  it "db - migrations" do
    done
  end

  it "controllers: UsersController, UserSessionsController" do
    done
  end

  it "controllers: ApplicationController helper methods" do
	  done
  end

  it "routes" do
    done
  end

  it "The root route: UserSession#new" do
    done( "fix the routing table" )
    done( "modify UserSession#new view", "pending" )
  end

  it "views" do
    done( "User" )
    done( "UserSession" )
  end
end
