
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
                  if-not hide-tabs? $ comp-hud-nav (:tab store) tabs
                    fn (next d!)
                      d! $ :: :tab next
                  when dev? $ comp-reel (>> states :reel) reel ({})
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns app.comp.container $ :require (respo-ui.css :as css)
            respo.css :refer $ defstyle
            respo.core :refer $ defcomp defeffect <> >> div button textarea span input
            respo.comp.space :refer $ =<
            reel.comp.reel :refer $ comp-reel
            app.config :refer $ dev? hide-tabs?
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
        |hide-tabs? $ %{} :CodeEntry (:doc |)
          :code $ quote
            def hide-tabs? $ = "\"true" (get-env "\"hide-tabs" false)
        |site $ %{} :CodeEntry (:doc |)
          :code $ quote
            def site $ {} (:storage-key "\"workflow")
        |skip-rendering? $ %{} :CodeEntry (:doc |)
          :code $ quote
            def skip-rendering? $ = "\"true" (get-env "\"skip" "\"false")
        |tabs $ %{} :CodeEntry (:doc |)
          :code $ quote
            def tabs $ [] (:: :fireworks |Fireworks :dark) (:: :lorenz |Lorenz :dark) (:: :aizawa |Aizawa :dark) (:: :fourwing "|Four Wing" :dark) (:: :fractal |Fractal :dark) (:: :collision |Collision :dark) (:: :bounce |Bounce :dark) (:: :feday |FEDAY :dark) (:: :bifurcation "\"Bifurcation" :dark) (:: :ball-spin "\"Ball Spin" :dark) (:: :lifegame "\"Lifegame" :dark) (:: :lifegame-trail "\"Lifegame Trail" :dark) (:: :bounce-trail "|Bounce Trail" :dark) (:: :orbit-spark "|Orbit Spark" :dark) (:: :chen |Chen :dark) (:: :sprott |Sprott :dark) (:: :lorenz83 |Lorenz83 :dark) (:: :orbits |Orbits :dark) (:: :lamps |Lamps :dark) (:: :debug-grid "|Debug Grid" :dark) (:: :den-tsucs "\"Den Tsucs" :dark) (:: :bouali "\"Bouali" :dark) (:: :orbits2 "\"Orbits 2" :dark) (:: :halvorsen "\"Halvorsen" :dark) (:: :clifford "\"Clifford" :dark) (:: :dequanli "\"Dequan Li" :dark) (:: :dadras "\"Dadras" :dark) (:: :burke-shaw "\"Burke Shaw" :dark) (:: :quadratic "\"Quadratic" :dark) (:: :rule1001 "\"rule1001" :dark)
        |threshold $ %{} :CodeEntry (:doc |)
          :code $ quote
            def threshold $ js/parseFloat
              or (get-env "\"threshold") "\"0.016"
        |use-gamepad? $ %{} :CodeEntry (:doc |)
          :code $ quote
            def use-gamepad? $ get-env "\"gamepad"
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
            defn dispatch! (op) (hint-fn async)
              when
                and config/dev? $ not= op :states
                js/console.log "\"Dispatch:" op
              reset! *reel $ reel-updater updater @*reel op
              tag-match op
                  :tab t theme
                  set-renderer! $ :tab (:store @*reel)
                _ $ eprintln "\"unknown op:" op
        |main! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn main! () (hint-fn async)
              js-await $ setupInitials canvas
              set! js/window.skipComputing config/skip-rendering?
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
              js-await $ set-renderer!
                :tab $ :store @*reel
              render-loop!
              listenShaderError $ fn (err)
                if (some? err) (hud! "\"error" err)
              println "|App started."
        |mount-target $ %{} :CodeEntry (:doc |)
          :code $ quote
            def mount-target $ js/document.querySelector |.app
        |persist-storage! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn persist-storage! ()
              println "\"Saved at" $ .!toISOString (new js/Date)
              js/localStorage.setItem (:storage-key config/site)
                format-cirru-edn $ :store @*reel
        |pick-renderer $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn pick-renderer (tab)
              case-default tab
                do (eprintln "\"unknown tab:" tab) (fireworks/loadRenderer canvas)
                :fireworks $ fireworks/loadRenderer canvas
                :lorenz $ lorenz/loadRenderer canvas
                :aizawa $ aizawa/loadRenderer canvas
                :fourwing $ fourwing/loadRenderer canvas
                :fractal $ fractal/loadRenderer canvas
                :collision $ collision/loadRenderer canvas
                :bounce $ bounce/loadRenderer canvas
                :bounce-trail $ bounce-trail/loadRenderer canvas
                :feday $ feday/loadRenderer canvas
                :bifurcation $ bifurcation/loadRenderer canvas
                :ball-spin $ ball-spin/loadRenderer canvas
                :lifegame $ lifegame/loadRenderer canvas
                :lifegame-trail $ lifegame-trail/loadRenderer canvas
                :orbit-spark $ orbit-spark/loadRenderer canvas
                :chen $ chen/loadRenderer canvas
                :sprott $ sprott/loadRenderer canvas
                :lorenz83 $ lorenz-83/loadRenderer canvas
                :orbits $ orbits/loadRenderer canvas
                :orbits2 $ orbits-2/loadRenderer canvas
                :lamps $ lamps/loadRenderer canvas
                :debug-grid $ debug-grid/loadRenderer canvas
                :den-tsucs $ den-tsucs/loadRenderer canvas
                :bouali $ bouali/loadRenderer canvas
                :halvorsen $ halvorsen/loadRenderer canvas
                :clifford $ clifford/loadRenderer canvas
                :dequanli $ dequanli/loadRenderer canvas
                :dadras $ dadras/loadRenderer canvas
                :burke-shaw $ burke-shaw/loadRenderer canvas
                :quadratic $ quadratic/loadRenderer canvas
                :rule1001 $ rule30/loadRenderer canvas
        |reload! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn reload! () (hint-fn async)
              if (nil? build-errors)
                do (remove-watch *reel :changes) (clear-cache!)
                  add-watch *reel :changes $ fn (reel prev) (render-app!)
                  reset! *reel $ refresh-reel @*reel schema/store updater
                  set-renderer! $ :tab (:store @*reel)
                  hud! "\"ok~" "\"Ok"
                hud! "\"error" build-errors
        |render-app! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn render-app! () $ render! mount-target (comp-container @*reel) dispatch!
        |render-loop! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn render-loop! () $ if (&< js-config/interval 10)
              do
                js/requestAnimationFrame $ fn (_t) (render-loop!)
                swap! *t inc
                @*instance-renderer @*t js/window.skipComputing
              js/setTimeout
                fn ()
                  js/requestAnimationFrame $ fn (_t) (render-loop!)
                  swap! *t inc
                  @*instance-renderer @*t js/window.skipComputing
                , js-config/interval
        |set-renderer! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn set-renderer! (name) (hint-fn async)
              let
                  renderer $ js-await (pick-renderer name)
                reset! *instance-renderer renderer
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
            "\"../src/apps/fireworks.mts" :as fireworks
            "\"../src/apps/attractor/aizawa.mts" :as aizawa
            "\"../src/apps/attractor/lorenz.mts" :as lorenz
            "\"../src/apps/attractor/fourwing.mts" :as fourwing
            "\"../src/apps/attractor/chen.mts" :as chen
            "\"../src/apps/attractor/sprott.mts" :as sprott
            "\"../src/apps/attractor/lorenz83.mts" :as lorenz-83
            "\"../src/apps/attractor/bouali.mts" :as bouali
            "\"../src/apps/attractor/halvorsen.mts" :as halvorsen
            "\"../src/apps/fractal.mts" :as fractal
            "\"../src/apps/collision.mts" :as collision
            "\"../src/apps/bounce.mts" :as bounce
            "\"../src/apps/bounce-trail.mts" :as bounce-trail
            "\"../src/apps/feday.mts" :as feday
            "\"../src/apps/bifurcation.mts" :as bifurcation
            "\"../src/apps/ball-spin.mts" :as ball-spin
            "\"../src/apps/lifegame.mts" :as lifegame
            "\"../src/apps/lifegame-trail.mts" :as lifegame-trail
            "\"../src/apps/orbit-spark.mts" :as orbit-spark
            "\"../src/apps/orbits.mts" :as orbits
            "\"../src/apps/orbits-2.mts" :as orbits-2
            "\"../src/apps/lamps.mts" :as lamps
            "\"../src/apps/debug-grid.mts" :as debug-grid
            "\"../src/apps/attractor/den-tsucs.mts" :as den-tsucs
            "\"../src/apps/clifford.mts" :as clifford
            "\"../src/apps/attractor/dequanli.mts" :as dequanli
            "\"../src/apps/attractor/dadras.mts" :as dadras
            "\"../src/apps/attractor/burke-shaw.mts" :as burke-shaw
            "\"../src/apps/quadratic.mts" :as quadratic
            "\"../src/apps/rule30.mts" :as rule30
            "\"../src/index.mts" :refer $ setupInitials
            "\"../src/config.mts" :as js-config
            "\"../src/index.mts" :refer $ listenShaderError
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
                (:tab t theme) (assoc store :tab t)
                (:hydrate-storage data) data
                _ $ do (eprintln "\"unknown op:" op) store
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns app.updater $ :require
            respo.cursor :refer $ update-states
