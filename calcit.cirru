
{}
  :about "|Machine-generated snapshot. Do not edit directly — changes will be overwritten. Use `calcit query` to inspect and `calcit edit`/`calcit tree` to modify. Run `calcit docs agents --contract` before mutations; use `--full` for first orientation or changed contract digest. Manual edits must follow format and schema conventions, then run `calcit edit format`."
  :package |app
  :entries $ {} $ :default
    {} (:description |) (:init-fn 'app.main/main!) (:mode :js) (:reload-fn 'app.main/reload!) (:target :browser)
      :feature-policy $ {}
      :modules $ [] |respo.calcit/ |lilac/ |respo-ui.calcit/ |reel.calcit/ |hud-nav/
      :type-slots $ {}
  :files $ {}
    'app.comp.container $ %{} 'FileEntry
      :defs $ {} $ 'comp-container
        %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-container (reel)
            let
                store $ :store reel
                states $ assert-type
                  option:unwrap-or (get store :states) ({})
                  :: 'Map 'Tag 'Dynamic
                tab $ assert-type
                  option:unwrap-or (get store :tab) default-tab
                  , 'Tag
              div ({})
                if-not hide-tabs? $ comp-hud-nav tab tabs
                when dev? $ comp-reel (>> states :reel) reel $ {}
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'respo.schema/Component)
            :args $ [] $ :: 'reel.typed/State 'Enum (:: 'Map 'Tag 'Dynamic)
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.container
          :require (respo-ui.css :as css)
            respo.css :refer $ defstyle
            respo.core :refer $ defcomp defeffect <> >> div button textarea span input
            respo.comp.space :refer $ =<
            reel.comp.reel :refer $ comp-reel
            app.config :refer $ dev? hide-tabs?
            app.config :refer $ default-tab tabs
            hud-nav.comp :refer $ comp-hud-nav
            reel.typed :as typed
    'app.config $ %{} 'FileEntry
      :defs $ {}
        'default-tab $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def default-tab
            turn-tag $ option:unwrap-or (get-env |tab) |rule1001
          :examples $ []
          :schema $ :: 'Tag
        'dev? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def dev?
            = |dev $ option:unwrap-or (get-env |mode) |release
          :examples $ []
          :schema $ :: 'Bool
        'hide-tabs? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def hide-tabs?
            = |true $ option:unwrap-or (get-env |hide-tabs) |false
          :examples $ []
          :schema $ :: 'Bool
        'site $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def site
            {} $ :storage-key |workflow
          :examples $ []
          :schema $ :: 'Map 'Tag 'String
        'skip-rendering? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def skip-rendering?
            = |true $ option:unwrap-or (get-env |skip) |false
          :examples $ []
          :schema $ :: 'Bool
        'tabs $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def tabs
            []
              %{} TabItem (:id :fireworks) (:label |Fireworks)
              %{} TabItem (:id :lorenz) (:label |Lorenz)
              %{} TabItem (:id :aizawa) (:label |Aizawa)
              %{} TabItem (:id :fourwing) (:label "|Four Wing")
              %{} TabItem (:id :fractal) (:label |Fractal)
              %{} TabItem (:id :collision) (:label |Collision)
              %{} TabItem (:id :bounce) (:label |Bounce)
              %{} TabItem (:id :feday) (:label |FEDAY)
              %{} TabItem (:id :bifurcation) (:label |Bifurcation)
              %{} TabItem (:id :ball-spin) (:label "|Ball Spin")
              %{} TabItem (:id :lifegame) (:label |Lifegame)
              %{} TabItem (:id :lifegame-trail) (:label "|Lifegame Trail")
              %{} TabItem (:id :bounce-trail) (:label "|Bounce Trail")
              %{} TabItem (:id :orbit-spark) (:label "|Orbit Spark")
              %{} TabItem (:id :chen) (:label |Chen)
              %{} TabItem (:id :sprott) (:label |Sprott)
              %{} TabItem (:id :lorenz83) (:label |Lorenz83)
              %{} TabItem (:id :orbits) (:label |Orbits)
              %{} TabItem (:id :lamps) (:label |Lamps)
              %{} TabItem (:id :debug-grid) (:label "|Debug Grid")
              %{} TabItem (:id :den-tsucs) (:label "|Den Tsucs")
              %{} TabItem (:id :bouali) (:label |Bouali)
              %{} TabItem (:id :orbits2) (:label "|Orbits 2")
              %{} TabItem (:id :halvorsen) (:label |Halvorsen)
              %{} TabItem (:id :clifford) (:label |Clifford)
              %{} TabItem (:id :dequanli) (:label "|Dequan Li")
              %{} TabItem (:id :dadras) (:label |Dadras)
              %{} TabItem (:id :burke-shaw) (:label "|Burke Shaw")
              %{} TabItem (:id :quadratic) (:label |Quadratic)
              %{} TabItem (:id :rule1001) (:label |rule1001)
          :examples $ []
          :schema $ :: 'List 'hud-nav.schema/TabItem
        'threshold $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def threshold 0.016
          :examples $ []
          :schema $ :: 'Number
        'use-gamepad? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def use-gamepad?
            option:some? $ get-env |gamepad
          :examples $ []
          :schema $ :: 'Bool
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.config
          :require $ hud-nav.schema :refer $ TabItem
    'app.main $ %{} 'FileEntry
      :defs $ {}
        '*instance-renderer $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defatom *instance-renderer nil
          :examples $ []
          :schema $ :: 'Ref 'Dynamic
        '*reel $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defatom *reel (typed/new-reel schema/store)
          :examples $ []
          :schema $ :: 'Ref $ :: 'reel.typed/State 'Enum (:: 'Map 'Tag 'Dynamic)
        '*t $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defatom *t 0
          :examples $ []
          :schema $ :: 'Ref 'Number
        'current-tab $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn current-tab ()
            let
                store $ :store @*reel
              assert-type
                option:unwrap-or (get store :tab) config/default-tab
                , 'Tag
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Tag)
            :args $ []
        'dispatch! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn dispatch! (op)
            when
              and config/dev? $ not= op :states
              js/console.log |Dispatch: op
            reset! *reel $ next-reel op
            match op
              (:tab t)
                set-renderer! $ current-tab
              (:states cursor s) &unit
              (:hydrate-storage data) &unit
              _ $ eprintln "|unknown op:" op
            , &unit
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ [] 'Dynamic
            :features $ #{} :js-ffi
        'get-canvas $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn get-canvas () (js/document.querySelector |canvas)
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Dynamic)
            :args $ []
            :features $ #{} :js-ffi
        'get-mount-target $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn get-mount-target () (js/document.querySelector |.app)
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Dynamic)
            :args $ []
            :features $ #{} :js-ffi
        'main! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn main! ()
            hint-fn $ {} $ :async true
            js-await $ setupInitials $ get-canvas
            set! js/window.skipComputing config/skip-rendering?
            println "|Running mode:" $ if config/dev? |dev |release
            if config/dev? $ load-console-formatter!
            render-app!
            add-watch *reel :changes $ fn (reel prev) (render-app!)
            listen-devtools! |k dispatch!
            ; js/window.addEventListener |beforeunload $ fn (event) (persist-storage!)
            ; js/window.addEventListener |visibilitychange $ fn (event)
              if (= |hidden js/document.visibilityState) (persist-storage!)
            ; let
              (raw (js/localStorage.getItem (:storage-key config/site)))
              when (some? raw)
                dispatch! $ :: :hydrate-storage $ parse-cirru-edn raw
            js-await $ set-renderer! $ current-tab
            render-loop!
            listenShaderError $ fn (err)
              if (some? err) (hud! |error err)
            println "|App started."
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Dynamic)
            :args $ []
            :features $ #{} :js-ffi
        'next-reel $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn next-reel (op)
            typed/record-op updater
              assert-type @*reel $ :: 'reel.typed/State 'Enum $ :: 'Map 'Tag 'Dynamic
              assert-type op 'Enum
              generate-id!
              unsafe-coerce (js/Date.now) 'Number
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] 'Dynamic
            :features $ #{} :js-ffi
            :return $ :: 'reel.typed/State 'Enum $ :: 'Map 'Tag 'Dynamic
        'persist-storage! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn persist-storage! ()
            println |Saved_at $ shared/date-now-snapshot
            browser/storage-set!
              option:unwrap $ get config/site :storage-key
              format-cirru-edn $ :store @*reel
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
            :features $ #{} :js-ffi
        'pick-renderer $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn pick-renderer (tab)
            case-default tab
              do (eprintln "|unknown tab:" tab)
                fireworks/loadRenderer $ get-canvas
              :fireworks $ fireworks/loadRenderer $ get-canvas
              :lorenz $ lorenz/loadRenderer $ get-canvas
              :aizawa $ aizawa/loadRenderer $ get-canvas
              :fourwing $ fourwing/loadRenderer $ get-canvas
              :fractal $ fractal/loadRenderer $ get-canvas
              :collision $ collision/loadRenderer $ get-canvas
              :bounce $ bounce/loadRenderer $ get-canvas
              :bounce-trail $ bounce-trail/loadRenderer $ get-canvas
              :feday $ feday/loadRenderer $ get-canvas
              :bifurcation $ bifurcation/loadRenderer $ get-canvas
              :ball-spin $ ball-spin/loadRenderer $ get-canvas
              :lifegame $ lifegame/loadRenderer $ get-canvas
              :lifegame-trail $ lifegame-trail/loadRenderer $ get-canvas
              :orbit-spark $ orbit-spark/loadRenderer $ get-canvas
              :chen $ chen/loadRenderer $ get-canvas
              :sprott $ sprott/loadRenderer $ get-canvas
              :lorenz83 $ lorenz-83/loadRenderer $ get-canvas
              :orbits $ orbits/loadRenderer $ get-canvas
              :orbits2 $ orbits-2/loadRenderer $ get-canvas
              :lamps $ lamps/loadRenderer $ get-canvas
              :debug-grid $ debug-grid/loadRenderer $ get-canvas
              :den-tsucs $ den-tsucs/loadRenderer $ get-canvas
              :bouali $ bouali/loadRenderer $ get-canvas
              :halvorsen $ halvorsen/loadRenderer $ get-canvas
              :clifford $ clifford/loadRenderer $ get-canvas
              :dequanli $ dequanli/loadRenderer $ get-canvas
              :dadras $ dadras/loadRenderer $ get-canvas
              :burke-shaw $ burke-shaw/loadRenderer $ get-canvas
              :quadratic $ quadratic/loadRenderer $ get-canvas
              :rule1001 $ rule30/loadRenderer $ get-canvas
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Dynamic)
            :args $ [] 'Dynamic
            :features $ #{} :js-ffi
        'reload! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn reload! ()
            hint-fn $ {} $ :async true
            if (nil? build-errors)
              do (remove-watch *reel :changes) (clear-cache!)
                add-watch *reel :changes $ fn (reel prev) (render-app!)
                reset! *reel $ typed/refresh updater
                  assert-type @*reel $ :: 'reel.typed/State 'Enum $ :: 'Map 'Tag 'Dynamic
                  assert-type schema/store $ :: 'Map 'Tag 'Dynamic
                set-renderer! $ current-tab
                hud! |ok~ |Ok
              hud! |error build-errors
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
            :features $ #{} :js-ffi
        'render-app! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn render-app! ()
            render! (get-mount-target) (comp-container @*reel) dispatch!
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
        'render-loop! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn render-loop! ()
            do
              if (&< js-config/interval 10)
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
              , &unit
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
            :features $ #{} :js-ffi
        'set-renderer! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn set-renderer! (name)
            hint-fn $ {} $ :async true
            let
                renderer $ js-await $ pick-renderer name
              reset! *instance-renderer renderer
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Dynamic)
            :args $ [] 'Dynamic
            :features $ #{} :js-ffi
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.main
          :require
            respo.core :refer $ render! clear-cache!
            app.comp.container :refer $ comp-container
            app.updater :refer $ updater
            app.schema :as schema
            reel.util :refer $ listen-devtools! generate-id!
            reel.typed :as typed
            app.config :as config
            |./calcit.build-errors :default build-errors
            |bottom-tip :default hud!
            |../src/apps/fireworks.mts :as fireworks
            |../src/apps/attractor/aizawa.mts :as aizawa
            |../src/apps/attractor/lorenz.mts :as lorenz
            |../src/apps/attractor/fourwing.mts :as fourwing
            |../src/apps/attractor/chen.mts :as chen
            |../src/apps/attractor/sprott.mts :as sprott
            |../src/apps/attractor/lorenz83.mts :as lorenz-83
            |../src/apps/attractor/bouali.mts :as bouali
            |../src/apps/attractor/halvorsen.mts :as halvorsen
            |../src/apps/fractal.mts :as fractal
            |../src/apps/collision.mts :as collision
            |../src/apps/bounce.mts :as bounce
            |../src/apps/bounce-trail.mts :as bounce-trail
            |../src/apps/feday.mts :as feday
            |../src/apps/bifurcation.mts :as bifurcation
            |../src/apps/ball-spin.mts :as ball-spin
            |../src/apps/lifegame.mts :as lifegame
            |../src/apps/lifegame-trail.mts :as lifegame-trail
            |../src/apps/orbit-spark.mts :as orbit-spark
            |../src/apps/orbits.mts :as orbits
            |../src/apps/orbits-2.mts :as orbits-2
            |../src/apps/lamps.mts :as lamps
            |../src/apps/debug-grid.mts :as debug-grid
            |../src/apps/attractor/den-tsucs.mts :as den-tsucs
            |../src/apps/clifford.mts :as clifford
            |../src/apps/attractor/dequanli.mts :as dequanli
            |../src/apps/attractor/dadras.mts :as dadras
            |../src/apps/attractor/burke-shaw.mts :as burke-shaw
            |../src/apps/quadratic.mts :as quadratic
            |../src/apps/rule30.mts :as rule30
            |../src/index.mts :refer $ setupInitials
            |../src/config.mts :as js-config
            |../src/index.mts :refer $ listenShaderError
            js-ffi.shared :as shared
            js-ffi.browser :as browser
    'app.schema $ %{} 'FileEntry
      :defs $ {} $ 'store
        %{} 'CodeEntry (:doc |)
          :code $ quote $ def store
            {} (:tab default-tab)
              :states $ {} $ :cursor ([])
          :examples $ []
          :schema $ :: 'Map 'Tag 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.schema
          :require $ app.config :refer $ default-tab
    'app.updater $ %{} 'FileEntry
      :defs $ {} $ 'updater
        %{} 'CodeEntry (:doc |)
          :code $ quote $ defn updater (store op op-id op-time)
            match op
              (:states cursor s) (update-states store cursor s)
              (:tab t) (assoc store :tab t)
              (:hydrate-storage data) data
              _ $ do (eprintln "|unknown op:" op) store
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] (:: 'Map 'Tag 'Dynamic) 'Enum 'String 'Number
            :return $ :: 'Map 'Tag 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.updater
          :require $ respo.cursor :refer $ update-states
