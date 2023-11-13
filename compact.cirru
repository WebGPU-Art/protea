
{} (:package |app)
  :configs $ {} (:init-fn |app.main/main!) (:reload-fn |app.main/reload!) (:version |0.0.1)
    :modules $ [] |respo.calcit/ |lilac/ |memof/ |respo-ui.calcit/ |reel.calcit/ |hud-nav/
  :entries $ {}
  :files $ {}
    |app.comp.container $ %{} :FileEntry
      :defs $ {}
        |comp-container $ %{} :CodeEntry (:doc |)
          :code $ quote
            defcomp comp-container (reel)
              let
                  store $ :store reel
                  states $ :states store
                  cursor $ or (:cursor states) ([])
                  state $ or (:data states)
                    {} $ :content "\""
                div ({})
                  comp-hud-nav (:tab store) tabs $ fn (next d!)
                    d! $ :: :tab next
                  when dev? $ comp-reel (>> states :reel) reel ({})
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns app.comp.container $ :require (respo-ui.css :as css)
            respo.css :refer $ defstyle
            respo.core :refer $ defcomp defeffect <> >> div button textarea span input
            respo.comp.space :refer $ =<
            reel.comp.reel :refer $ comp-reel
            app.config :refer $ dev?
            app.config :refer $ tabs
            hud-nav.comp :refer $ comp-hud-nav
    |app.config $ %{} :FileEntry
      :defs $ {}
        |default-tab $ %{} :CodeEntry (:doc |)
          :code $ quote
            def default-tab $ turn-tag
              get-env "\"tab" $ turn-string
                nth (last tabs) 0
        |dev? $ %{} :CodeEntry (:doc |)
          :code $ quote
            def dev? $ = "\"dev" (get-env "\"mode" "\"release")
        |site $ %{} :CodeEntry (:doc |)
          :code $ quote
            def site $ {} (:storage-key "\"workflow")
        |tabs $ %{} :CodeEntry (:doc |)
          :code $ quote
            def tabs $ [] (:: :fireworks |Fireworks :dark) (:: :lorenz |Lorenz :dark) (:: :aizawa |Aizawa :dark) (:: :fourwing "|Four Wing" :dark) (:: :fractal |Fractal :dark) (:: :collision |Collision :dark)
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns app.config $ :require
            app.schema :refer $ tabs
    |app.main $ %{} :FileEntry
      :defs $ {}
        |*instance-renderer $ %{} :CodeEntry (:doc |)
          :code $ quote (defatom *instance-renderer nil)
        |*reel $ %{} :CodeEntry (:doc |)
          :code $ quote
            defatom *reel $ -> reel-schema/reel (assoc :base schema/store) (assoc :store schema/store)
        |*t $ %{} :CodeEntry (:doc |)
          :code $ quote (defatom *t 0)
        |canvas $ %{} :CodeEntry (:doc |)
          :code $ quote
            def canvas $ js/document.querySelector "\"canvas"
        |dispatch! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn dispatch! (op)
              when
                and config/dev? $ not= op :states
                js/console.log "\"Dispatch:" op
              reset! *reel $ reel-updater updater @*reel op
              tag-match op
                  :tab t
                  load-renderer t
                _ :ok
        |load-renderer $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn load-renderer (tab) (hint-fn async)
              let
                  renderer $ js-await
                    case-default tab
                      do (eprintln "\"unknown tab:" tab) (loadFireworksRenderer canvas)
                      :fireworks $ loadFireworksRenderer canvas
                      :lorenz $ loadLorenzRenderer canvas
                      :lorenz $ loadLorenzRenderer canvas
                      :aizawa $ loadAizawaRenderer canvas
                      :fourwing $ loadFourwingRenderer canvas
                      :fractal $ loadFractalRenderer canvas
                      :collision $ loadCollisionRenderer canvas
                reset! *instance-renderer renderer
        |loop-renderer! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn loop-renderer! () $ js/setTimeout
              fn ()
                js/requestAnimationFrame $ fn (_t) (loop-renderer!)
                swap! *t inc
                @*instance-renderer @*t false
              , 20
        |main! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn main! () (hint-fn async)
              js-await $ setupInitials canvas
              println "\"Running mode:" $ if config/dev? "\"dev" "\"release"
              if config/dev? $ load-console-formatter!
              render-app!
              add-watch *reel :changes $ fn (reel prev) (render-app!)
              listen-devtools! |k dispatch!
              ; js/window.addEventListener |beforeunload $ fn (event) (persist-storage!)
              ; js/window.addEventListener |visibilitychange $ fn (event)
                if (= "\"hidden" js/document.visibilityState) (persist-storage!)
              ; let
                  raw $ js/localStorage.getItem (:storage-key config/site)
                when (some? raw)
                  dispatch! $ :: :hydrate-storage (parse-cirru-edn raw)
              println "|App started."
              ->
                load-renderer $ :tab (:store @*reel)
                .!then $ fn (r) (loop-renderer!)
        |mount-target $ %{} :CodeEntry (:doc |)
          :code $ quote
            def mount-target $ js/document.querySelector |.app
        |persist-storage! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn persist-storage! ()
              println "\"Saved at" $ .!toISOString (new js/Date)
              js/localStorage.setItem (:storage-key config/site)
                format-cirru-edn $ :store @*reel
        |reload! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn reload! () (hint-fn async)
              if (nil? build-errors)
                do (remove-watch *reel :changes) (clear-cache!)
                  add-watch *reel :changes $ fn (reel prev) (render-app!)
                  reset! *reel $ refresh-reel @*reel schema/store updater
                  js-await $ load-renderer
                    :tab $ :store @*reel
                  hud! "\"ok~" "\"Ok"
                hud! "\"error" build-errors
        |render-app! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn render-app! () $ render! mount-target (comp-container @*reel) dispatch!
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns app.main $ :require
            respo.core :refer $ render! clear-cache!
            app.comp.container :refer $ comp-container
            app.updater :refer $ updater
            app.schema :as schema
            reel.util :refer $ listen-devtools!
            reel.core :refer $ reel-updater refresh-reel
            reel.schema :as reel-schema
            app.config :as config
            "\"./calcit.build-errors" :default build-errors
            "\"bottom-tip" :default hud!
            "\"../src/apps/fireworks" :refer $ loadFireworksRenderer
            "\"../src/apps/attractor-aizawa" :refer $ loadAizawaRenderer
            "\"../src/apps/attractor-lorenz" :refer $ loadLorenzRenderer
            "\"../src/apps/attractor-fourwing" :refer $ loadFourwingRenderer
            "\"../src/apps/fractal" :refer $ loadFractalRenderer
            "\"../src/apps/collision" :refer $ loadCollisionRenderer
            "\"../src/index" :refer $ setupInitials
    |app.schema $ %{} :FileEntry
      :defs $ {}
        |store $ %{} :CodeEntry (:doc |)
          :code $ quote
            def store $ {} (:tab default-tab)
              :states $ {}
                :cursor $ []
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns app.schema $ :require
            app.config :refer $ default-tab
    |app.updater $ %{} :FileEntry
      :defs $ {}
        |updater $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn updater (store op op-id op-time)
              tag-match op
                  :states cursor s
                  update-states store cursor s
                (:tab t) (assoc store :tab t)
                (:hydrate-storage data) data
                _ $ do (eprintln "\"unknown op:" op) store
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns app.updater $ :require
            respo.cursor :refer $ update-states
