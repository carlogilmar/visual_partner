defmodule StarWeb.Router do
  use StarWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_layout, {StarWeb.LayoutView, :app}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser_pipeline do
    plug Star.Guardian.BrowserPipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", StarWeb do
    pipe_through :browser
    get "/", PageController, :index

    ### Login for admin
    get "/home", LoginController, :index
    post "/login", LoginController, :login
    get "/logout", LoginController, :logout

    ### Create Users and Login
    get "/welcome", SignupController, :index
    post "/sign_up", SignupController, :create_user
    post "/suscribe", SignupController, :suscribe
    live "/register/:id", RegisterLive

    ### Gallery
    live "/visual/:type", GalleryLive
    get "/gallery/:id", ImagesController, :index

    ### Sponsors
    live "/sponsorship", SponsorsLive

    ### Contact
    live "/contact", ContactLive

    ### Notes
    get "/note/:id", NoteController, :index

    ### Roster
    get "/visual_roster", RosterController, :index

    ### Releases
    live "/releases", ReleasesLive

    ### Apprentice
    get "/apprentice", ApprenticeController, :index

    ### Visual Partner
    get "/visual_partner", PartnerController, :index

    ### Blog
    live "/blog", BlogLive

    ### Talks
    live "/talks", ResourcesLive

    ### Como Vas
    live "/personal", TaskLive

    ## Show Deliverable
    live "/deliverable/:id", DeliverableLive
    get "/deliverables/:id", DeliverablesController, :index
  end

  ## Admin
  scope "/admin", StarWeb do
    pipe_through [:browser, :browser_pipeline, :ensure_auth]
    get "/", TasksController, :index
    live "/users", UsersLive
    live "/suscriptors", SuscriptorsLive
    get "/analytics", AnalyticsController, :index
    live "/emailer", EmailerLive
    get "/email/:id", EmailController, :index
    live "/gallery", GpageLive
    get "/gallery/:id", BundleController, :index
    live "/sponsorship", SponsorshipLive
    get "/notes", NotesController, :index
    live "/comments", CommentsLive
    live "/model", ModelLive
    live "/event", EventLive
    live "/talks", TalksLive
    live "/review", ReviewLive
    get "/management", ManagementController, :index
    live "/courses", CourseLive
    get "/course_creation/:id", CourseCreationController, :index
    get "/course_session/:id", Course_sessionController, :index
  end

  ## Users
  scope "/user", StarWeb do
    pipe_through [:browser, :browser_pipeline, :ensure_auth]
    get "/", UserController, :index
    get "/enrollment/:id", EnrollmentController, :index
    live "/registration/:user_id/:course_id", RegistrationLive
  end
end
