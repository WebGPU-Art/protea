
{}
  :about "|Machine-generated snapshot. Do not edit directly — changes will be overwritten. Use `calcit query` to inspect and `calcit edit`/`calcit tree` to modify. Run `calcit docs agents --contract` before mutations; use `--full` for first orientation or changed contract digest. Manual edits must follow format and schema conventions, then run `calcit edit format`."
  :package |app
  :entries $ {} $ :default
    {} (:description |) (:init-fn 'app.main/main!) (:mode :js) (:reload-fn 'app.main/reload!) (:target :browser)
      :feature-policy $ {}
      :modules $ [] |respo.calcit/ |respo-ui.calcit/ |reel.calcit/ |hud-nav/
      :type-slots $ {} $ :dispatch-op 'app.schema/ViewOp
  :files $ {}
    'app.comp.container $ %{} 'FileEntry
      :defs $ {} $ 'comp-container
        %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-container (reel on-control!)
            let
                store $ :store reel
                tab $ :tab store
              div ({})
                if hide-tabs? None $ Some $ comp-hud-nav tab tabs
                if dev?
                  Some $ comp-typed-reel ({}) reel ({}) on-control!
                  , None
          :examples $ []
          :schema $ quote $ Fn (typed/State app.schema/AppOp app.schema/Store)
            Fn typed/Control $ -> Unit
            -> respo.schema/Component
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.container
          :require (respo-ui.css :as css)
            respo.css :refer $ defstyle
            respo.core :refer $ defcomp defeffect <> div button textarea span input
            respo.comp.space :refer $ =<
            reel.comp.reel :refer $ comp-typed-reel
            app.config :refer $ dev? hide-tabs?
            app.config :refer $ default-tab tabs
            hud-nav.comp :refer $ comp-hud-nav
            reel.typed :as typed
    'app.config $ %{} 'FileEntry
      :defs $ {}
        'default-tab $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def default-tab
            turn-tag $ .unwrap-or (get-env |tab) |rule1001
          :examples $ []
          :schema $ quote Tag
        'dev? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def dev?
            = |dev $ .unwrap-or (get-env |mode) |release
          :examples $ []
          :schema $ quote Bool
        'hide-tabs? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def hide-tabs?
            = |true $ .unwrap-or (get-env |hide-tabs) |false
          :examples $ []
          :schema $ quote Bool
        'site $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def site
            {} $ :storage-key |workflow
          :examples $ []
          :schema $ quote $ Map Tag String
        'skip-rendering? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def skip-rendering?
            = |true $ .unwrap-or (get-env |skip) |false
          :examples $ []
          :schema $ quote Bool
        'tabs $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def tabs
            [] (TabItem :id :fireworks :label |Fireworks) (TabItem :id :lorenz :label |Lorenz) (TabItem :id :aizawa :label |Aizawa) (TabItem :id :fourwing :label "|Four Wing") (TabItem :id :fractal :label |Fractal) (TabItem :id :collision :label |Collision) (TabItem :id :bounce :label |Bounce) (TabItem :id :feday :label |FEDAY) (TabItem :id :bifurcation :label |Bifurcation) (TabItem :id :ball-spin :label "|Ball Spin") (TabItem :id :lifegame :label |Lifegame) (TabItem :id :lifegame-trail :label "|Lifegame Trail") (TabItem :id :bounce-trail :label "|Bounce Trail") (TabItem :id :orbit-spark :label "|Orbit Spark") (TabItem :id :chen :label |Chen) (TabItem :id :sprott :label |Sprott) (TabItem :id :lorenz83 :label |Lorenz83) (TabItem :id :orbits :label |Orbits) (TabItem :id :lamps :label |Lamps) (TabItem :id :debug-grid :label "|Debug Grid") (TabItem :id :den-tsucs :label "|Den Tsucs") (TabItem :id :bouali :label |Bouali) (TabItem :id :orbits2 :label "|Orbits 2") (TabItem :id :halvorsen :label |Halvorsen) (TabItem :id :clifford :label |Clifford) (TabItem :id :dequanli :label "|Dequan Li") (TabItem :id :dadras :label |Dadras) (TabItem :id :burke-shaw :label "|Burke Shaw") (TabItem :id :quadratic :label |Quadratic) (TabItem :id :rule1001 :label |rule1001)
          :examples $ []
          :schema $ quote $ List TabItem
        'threshold $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def threshold 0.016
          :examples $ []
          :schema $ quote Number
        'use-gamepad? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def use-gamepad?
            .some? $ get-env |gamepad
          :examples $ []
          :schema $ quote Bool
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.config
          :require $ hud-nav.schema :refer $ TabItem
    'app.main $ %{} 'FileEntry
      :defs $ {}
        '*instance-renderer $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defref *instance-renderer None
          :examples $ []
          :schema $ quote $ Ref
            Option $ Fn Number Bool (-> Unit) (:features :js-ffi)
        '*reel $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defref *reel (typed/new-reel schema/store)
          :examples $ []
          :schema $ quote $ Ref (typed/State schema/AppOp schema/Store)
        '*t $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defref *t 0
          :examples $ []
          :schema $ quote $ Ref Number
        'current-tab $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn current-tab ()
            :tab $ :store @*reel
          :examples $ []
          :schema $ quote $ Fn (-> Tag) (:features :state)
        'dispatch! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn dispatch! (op)
            when config/dev? $ js/console.log |Dispatch: op
            let
                previous-tab $ current-tab
              reset! *reel $ typed/record-op updater @*reel op (generate-id!) (shared/now-ms)
              match op
                (:tab _)
                  set-renderer! $ current-tab
                (:hydrate-storage _)
                  when
                    not= previous-tab $ current-tab
                    set-renderer! $ current-tab
            , &unit
          :examples $ []
          :schema $ quote $ Fn schema/AppOp (-> Unit) (:features :io :js-ffi :state)
        'dispatch-view! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn dispatch-view! (op)
            match op
              (app.schema/AppOp action) (dispatch! action)
              (hud-nav.schema/Op action)
                match action
                  (:tab tab)
                    dispatch! $ schema/AppOp :tab tab
                  (:hydrate-storage _) (raise |expected-hud-nav-tab-operation)
          :examples $ []
          :schema $ quote $ Fn schema/ViewOp (-> Unit) (:features :io :state)
        'frame-interval $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def frame-interval (contract/expect-number |frame-interval js-config/interval)
          :examples $ []
          :schema $ quote Number
        'get-canvas $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn get-canvas ()
            .unwrap $ browser/query-selector |canvas
          :examples $ []
          :schema $ quote $ Fn (-> browser/DomElementHost) (:features :js-ffi)
        'get-mount-target $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn get-mount-target ()
            dom/narrow-element $ .unwrap $ browser/query-selector |.app
          :examples $ []
          :schema $ quote $ Fn (-> respo.dom/DomElement) (:features :js-ffi)
        'main! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn main! () (hint-fn Async)
            js-await $ setupInitials $ get-canvas
            set! js/window.skipComputing config/skip-rendering?
            println "|Running mode:" $ if config/dev? |dev |release
            if config/dev? $ load-console-formatter!
            render-app!
            add-watch! *reel :changes $ fn (reel prev) (render-app!)
            listen-devtools! |k on-control!
            ; js/window.addEventListener |beforeunload $ fn (event) (persist-storage!)
            ; js/window.addEventListener |visibilitychange $ fn (event)
              if (= |hidden js/document.visibilityState) (persist-storage!)
            ; let
              (raw (js/localStorage.getItem (:storage-key config/site)))
              when (non-nil? raw)
                dispatch! $ schema/AppOp :hydrate-storage $ decode-map-as (parse-cirru-edn raw) schema/Store
            js-await $ set-renderer! $ current-tab
            render-loop!
            listenShaderError $ fn (err)
              if (non-nil? err) (hud! |error err)
            println "|App started."
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :io :js-ffi :state)
        'on-control! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn on-control! (control)
            let
                previous-tab $ current-tab
              reset! *reel $ typed/apply-control updater @*reel control
              when
                not= previous-tab $ current-tab
                set-renderer! $ current-tab
            , &unit
          :examples $ []
          :schema $ quote $ Fn typed/Control (-> Unit) (:features :io :state)
        'persist-storage! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn persist-storage! ()
            println |Saved_at $ shared/date-now-snapshot
            browser/storage-set!
              .unwrap $ get config/site :storage-key
              format-cirru-edn $ :store @*reel
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :io :js-ffi :state)
        'pick-renderer $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn pick-renderer (tab)
            contract/expect-object |renderer-promise $ match tab
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
              _ $ do (eprintln "|unknown tab:" tab)
                fireworks/loadRenderer $ get-canvas
          :examples $ []
          :schema $ quote $ Fn Tag (-> JsObject) (:features :io :js-ffi)
        'reload! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn reload! () (hint-fn Async)
            if (nil? build-errors)
              do (remove-watch! *reel :changes) (clear-cache!)
                add-watch! *reel :changes $ fn (reel prev) (render-app!)
                reset! *reel $ typed/refresh updater @*reel schema/store
                set-renderer! $ current-tab
                hud! |ok~ |Ok
              hud! |error build-errors
            , &unit
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :io :js-ffi :state)
        'render-app! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn render-app! ()
            render-with! (get-mount-target)
              fn () $ comp-container @*reel on-control!
              , dispatch-view!
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :io :state)
        'render-loop! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn render-loop! ()
            if (&< frame-interval 10)
              do
                browser/request-animation-frame! $ fn (_t) (render-loop!)
                swap! *t inc
                let
                    render! $ .unwrap @*instance-renderer
                  render! @*t $ contract/expect-bool |skip-computing js/window.skipComputing
              browser/set-timeout!
                fn ()
                  browser/request-animation-frame! $ fn (_t) (render-loop!)
                  swap! *t inc
                  let
                      render! $ .unwrap @*instance-renderer
                    render! @*t $ contract/expect-bool |skip-computing js/window.skipComputing
                  , &unit
                , frame-interval
            , &unit
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :js-ffi :state)
        'renderer-callback $ %{} 'CodeEntry
          :doc "|Validate the loaded JS renderer once and expose the frame callback with the Number/Bool contract. Frames stay fire-and-forget."
          :code $ quote $ defn renderer-callback (raw)
            let
                renderer $ contract/expect-function |renderer raw
              fn (tick skip?)
                hint-fn $ Fn Number Bool (-> Unit) (:features :js-ffi)
                js/Reflect.apply renderer js/undefined $ to-js-data $ [] tick skip?
                , &unit
          :examples $ []
          :schema $ quote $ Fn Input
            -> $ Fn Number Bool (-> Unit) (:features :js-ffi)
            :generics Input
            :features :js-ffi
        'set-renderer! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn set-renderer! (name) (hint-fn Async)
            let
                renderer $ js-await $ pick-renderer name
              when
                = name $ current-tab
                reset! *instance-renderer $ Some $ renderer-callback renderer
            , &unit
          :examples $ []
          :schema $ quote $ Fn Tag (-> Unit) (:features :io :js-ffi :state)
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.main
          :require
            respo.core :refer $ render-with! clear-cache!
            app.comp.container :refer $ comp-container
            app.updater :refer $ updater
            app.schema :as schema
            reel.util :refer $ listen-devtools!
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
            respo.ffi.browser :as dom
            js-ffi.contract :as contract
    'app.schema $ %{} 'FileEntry
      :defs $ {}
        'AppOp $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defenum AppOp (:tab Tag) (:hydrate-storage app.schema/Store)
          :examples $ []
          :schema $ quote EnumDef
        'Store $ %{} 'CodeEntry
          :doc "|Application state records the active renderer tab."
          :code $ quote $ defstruct Store (:tab Tag)
          :examples $ []
          :schema $ quote StructDef
        'ViewOp $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defunion ViewOp AppOp hud-nav.schema/Op
          :examples $ []
          :schema $ quote UnionDef
        'store $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def store (Store :tab default-tab)
          :examples $ []
          :schema $ quote Store
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.schema
          :require $ app.config :refer $ default-tab
    'app.updater $ %{} 'FileEntry
      :defs $ {} $ 'updater
        %{} 'CodeEntry (:doc |)
          :code $ quote $ defn updater (store op op-id op-time)
            match op
              (:tab tab) (assoc store :tab tab)
              (:hydrate-storage data) data
          :examples $ []
          :schema $ quote $ Fn app.schema/Store app.schema/AppOp String Number (-> app.schema/Store)
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.updater
