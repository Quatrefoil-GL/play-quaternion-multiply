
{}
  :about "|Machine-generated snapshot. Do not edit directly — changes will be overwritten. Use `calcit query` to inspect and `calcit edit`/`calcit tree` to modify. Run `calcit docs agents --contract` before mutations; use `--full` for first orientation or changed contract digest. Manual edits must follow format and schema conventions, then run `calcit edit format`."
  :package |app
  :entries $ {} $ :default
    {} (:description |) (:init-fn 'app.main/main!) (:mode :native) (:reload-fn 'app.main/reload!)
      :feature-policy $ {}
      :modules $ [] |touch-control/ |pointed-prompt/ |quatrefoil/ |quaternion/ |js-ffi/
      :type-slots $ {}
  :files $ {}
    'app.comp.container $ %{} 'FileEntry
      :defs $ {}
        'comp-container $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-container (store)
            let
                states $ field store :states
                cursor $ field states :cursor
                state $ either (field states :data)
                  {} $ :tab :portal
                tab $ field state :tab
                scaled 0.02
              scene ({})
                group
                  {}
                    :scale $ [] scaled scaled scaled
                    :position $ [] 0 1.2 -0.5
                  comp-multiply $ >> states :multiply
                  ambient-light $ {} $ :color 0x666666
                  ; point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                    :position $ [] 20 40 50
                  ; point-light $ {} (:color 0xffffff) (:intensity 2) (:distance 200)
                    :position $ [] 0 60 0
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Dynamic)
            :args $ [] $ :: 'Map 'Tag 'Dynamic
            :features $ #{} :js-ffi
        'field $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn field (value key)
            option:unwrap-or (get value key) nil
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Dynamic)
            :args $ [] (:: 'Map 'Tag 'Dynamic) 'Tag
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.container
          :require
            quatrefoil.alias :refer $ group box sphere point-light ambient-light perspective-camera scene text
            quatrefoil.core :refer $ defcomp >>
            app.comp.multiply :refer $ comp-multiply
    'app.comp.multiply $ %{} 'FileEntry
      :defs $ {}
        'as-bool $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn as-bool (value) (unsafe-coerce value Bool)
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Bool)
            :args $ [] 'Dynamic
            :features $ #{} :js-ffi
        'as-number $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn as-number (value) (unsafe-coerce value Number)
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Number)
            :args $ [] 'Dynamic
            :features $ #{} :js-ffi
        'calc-points $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn calc-points (p0 next times)
            if (<= times 0) ([])
              calc-points-loop ([] p0) (&q* next p0) next $ dec times
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'Number
            :return $ :: 'List 'quaternion.core/Quaternion
        'calc-points-loop $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn calc-points-loop (acc p next times)
            if (<= times 0) acc $ calc-points-loop (conj acc p) (&q* next p) next $ dec times
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] (:: 'List 'quaternion.core/Quaternion) 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'Number
            :return $ :: 'List 'quaternion.core/Quaternion
        'comp-labels $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-labels (a-position b-position)
            group ({})
              text $ {} (:text |b) (:size 2) (:height 0.1) (:position b-position)
                :material $ {} (:kind :mesh-lambert) (:color 0xffcccc) (:opacity 0.9) (:transparent true)
              text $ {} (:text |a) (:size 2) (:height 0.1) (:position a-position)
                :material $ {} (:kind :mesh-lambert) (:color 0xffcccc) (:opacity 0.9) (:transparent true)
              text $ {} (:text |z) (:size 2) (:height 0.1)
                :position $ [] 0 0 20
                :material $ {} (:kind :mesh-lambert) (:color 0x664488) (:opacity 0.9) (:transparent true)
              text $ {} (:text |y) (:size 2) (:height 0.1)
                :position $ [] 0 20 0
                :material $ {} (:kind :mesh-lambert) (:color 0x664488) (:opacity 0.9) (:transparent true)
              text $ {} (:text |x) (:size 2) (:height 0.1)
                :position $ [] 20 0 0
                :material $ {} (:kind :mesh-lambert) (:color 0x664488) (:opacity 0.9) (:transparent true)
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Dynamic)
            :args $ [] (:: 'List 'Number) (:: 'List 'Number)
            :features $ #{} :js-ffi
        'comp-multiply $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-multiply (states)
            let
                cursor $ field states :cursor
                state $ or (field states :data)
                  {} (:w-ratio 0.4) (:z-base 0) (:z-inc 0) (:z-inc-size 1) (:rotate-inc 1) (:a-w 0) (:rotate-inc-size 1) (:show-labels? true)
                w-ratio $ as-number $ field state :w-ratio
                z-base $ as-number $ field state :z-base
                z-inc $ as-number $ field state :z-inc
                z-inc-size $ as-number $ field state :z-inc-size
                rotate-inc-size $ as-number $ field state :rotate-inc-size
                a-w $ as-number $ field state :a-w
                show-labels? $ as-bool $ field state :show-labels?
                multiplier $ let
                    x 0
                    y 0
                    w w-ratio
                    rest-space $ - 1 (pow x 2) (pow y 2) (pow w 2)
                    z_ $ if (>= rest-space 0) (sqrt rest-space) 0
                  quaternion w x y z_
                scaled-multiplier $ q-scale multiplier 10
              group ({}) element-axis
                group ({}) & $ ->
                  range $ ceil z-inc-size
                  mapcat $ fn (idx)
                    hint-fn $ {}
                      :args $ [] 'Number
                      :return $ :: 'List 'Dynamic
                    let
                        start $ q+ (quaternion a-w 8 5 z-base)
                          quaternion 0 0 0 $ * z-inc idx
                        points $ calc-points start multiplier $ ceil rotate-inc-size
                      []
                        group ({}) & $ -> points $ map-indexed
                          fn (point-idx p)
                            comp-point p $ = 0 point-idx
                        line $ {}
                          :points $ map points quaternion-position
                          :position $ [] 0 0 0
                          :material $ {} (:kind :line-dashed) (:color 0xaaaaff) (:opacity 1) (:transparent false)
                comp-point scaled-multiplier true
                if show-labels? $ comp-labels
                  quaternion-position $ quaternion a-w 8 5 z-base
                  quaternion-position scaled-multiplier
                comp-value
                  {} (:speed 0.04) (:show-text? true) (:label |w-ratio) (:value w-ratio)
                    :position $ [] 4 2 12
                    :bound $ [] 0 1
                    :color 0xffff55
                  fn (v1 d!)
                    d! cursor $ assoc state :w-ratio v1
                comp-value
                  {} (:speed 1) (:show-text? true) (:label |z-base) (:value z-base)
                    :position $ [] 12 12 1
                    :bound $ [] -20 60
                    :color 0xffff55
                  fn (v1 d!)
                    d! cursor $ assoc state :z-base v1
                comp-value
                  {} (:speed 2) (:show-text? true) (:label |a-w) (:value a-w)
                    :position $ [] 12 22 1
                    :bound $ [] 0 20
                    :color 0x77ffcc
                  fn (v1 d!)
                    d! cursor $ assoc state :a-w v1
                comp-value
                  {} (:speed 1) (:show-text? true) (:label |z-inc) (:value z-inc)
                    :position $ [] 13 14 4
                    :bound $ [] 0.4 20
                    :color 0xffff55
                  fn (v1 d!)
                    d! cursor $ assoc state :z-inc v1
                comp-value
                  {} (:speed 1) (:show-text? true) (:label |z-inc-size) (:value z-inc-size)
                    :position $ [] 18 15 1
                    :bound $ [] 1 6
                    :color 0xff55ff
                  fn (v1 d!)
                    d! cursor $ assoc state :z-inc-size v1
                comp-value
                  {} (:speed 2) (:show-text? true) (:label |rotate-inc-size) (:value rotate-inc-size)
                    :position $ [] -4 4 -20
                    :bound $ [] 1 20
                    :color 0xff55ff
                  fn (v1 d!)
                    d! cursor $ assoc state :rotate-inc-size v1
                comp-switch
                  {} (:label |labels?) (:color 0x8855ff) (:value show-labels?)
                    :position $ [] 30 0 0
                  fn (v d!)
                    d! cursor $ assoc state :show-labels? v
                point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                  :position $ [] 20 40 50
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Dynamic)
            :args $ [] $ :: 'Map 'Tag 'Dynamic
            :features $ #{} :js-ffi
        'comp-point $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-point (position first?)
            let
                point $ quaternion-position position
              group ({})
                sphere $ {} (:radius 0.5) (:position point)
                  :material $ {} (:kind :mesh-standard) (:opacity 0.6) (:transparent true)
                    :color $ if first? 0xffaa88 0xcc88cc
                tube $ {} (:points-fn w-hint-fn)
                  :factor $ quaternion-s position
                  :radius 0.1
                  :tubularSegments 400
                  :radialSegments 20
                  :position point
                  :material $ {} (:kind :mesh-standard) (:color 0xdd0088) (:opacity 0.6) (:transparent false)
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Dynamic)
            :args $ [] 'quaternion.core/Quaternion 'Bool
            :features $ #{} :js-ffi
        'element-axis $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def element-axis
            group ({})
              line $ {}
                :points $ [] ([] -20 0 0) zero-point ([] 20 0 0) zero-point ([] 0 20 0) zero-point $ [] 0 -20 0
                :material cover-line
              line $ {}
                :points $ [] ([] 0 0 20) ([] 0 0 -20)
                :material $ assoc cover-line :color 0xffff99
          :examples $ []
          :schema $ :: 'Dynamic
        'field $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn field (value key)
            option:unwrap-or (get value key) nil
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Dynamic)
            :args $ [] (:: 'Map 'Tag 'Dynamic) 'Tag
        'quaternion-position $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn quaternion-position (value)
            match value $
              :quaternion s x y z
              [] x y z s
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] 'quaternion.core/Quaternion
            :return $ :: 'List 'Number
        'quaternion-s $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn quaternion-s (value)
            match value $
              :quaternion s _x _y _z
              , s
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Number)
            :args $ [] 'quaternion.core/Quaternion
        'w-hint-fn $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn w-hint-fn (ratio factor)
            [] 0 (* ratio factor) 0
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] 'Number 'Number
            :return $ :: 'List 'Number
        'zero-point $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def zero-point ([] 0 0 0)
          :examples $ []
          :schema $ :: 'List 'Number
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.multiply
          :require
            quatrefoil.alias :refer $ group box sphere text line tube point-light
            quatrefoil.core :refer $ defcomp
            quaternion.core :refer $ &q* q+ q-scale quaternion
            quatrefoil.comp.control :refer $ comp-pin-point comp-switch comp-value
            quatrefoil.app.materials :refer $ cover-line
    'app.main $ %{} 'FileEntry
      :defs $ {}
        '*store $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defatom *store
            {} $ :states $ {}
              :cursor $ []
          :examples $ []
          :schema $ :: 'Ref $ :: 'Map 'Tag 'Dynamic
        'MobileDetectHost $ %{} 'CodeEntry (:doc |)
          :code $ quote $ deftrait MobileDetectHost
            .mobile? $ :: 'Fn $ {}
              :args $ [] 'app.main/MobileDetectHost
              :return 'Bool
          :examples $ []
          :ffi $ {} (:backend :js) (:kind :external-object) (:target :browser)
            :names $ {} $ :mobile? |mobile
          :schema $ :: 'Trait
        'dispatch! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn dispatch! (op op-data)
            if (list? op)
              recur :states $ [] op op-data
              let
                  store $ updater @*store op op-data
                ; js/console.log |Dispatch: op op-data store
                reset! *store store
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ [] 'Dynamic 'Dynamic
            :features $ #{} :js-ffi
        'main! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn main! () (load-console-formatter!) (inject-tree-methods)
            set-perspective-camera! $ {} (:fov 40) (:near 0.1) (:far 100)
              :position $ [] 0 0 8
              :aspect $ / (viewport-width) (viewport-height)
            let
                canvas-el $ option:unwrap $ query-selector |canvas
              init-renderer! canvas-el $ {} $ :background 0x110022
            render-app!
            add-watch *store :changes $ fn (store prev) (render-app!)
            set! js/window.onkeydown handle-key-event
            when (mobile?) (render-control!) (handle-control-events)
            init-controls!
            println |App-started!
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
            :features $ #{} :js-ffi
        'mobile? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn mobile? ()
            let
                detector $ unsafe-coerce (new mobile-detect js/window.navigator.userAgent) app.main/MobileDetectHost
              detector .mobile?
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Bool)
            :args $ []
            :features $ #{} :js-ffi
        'reload! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn reload! ()
            if (some? build-errors) (hud! |error build-errors)
              do (hud! |ok~ nil) (clear-cache!)
                when (mobile?) (clear-control-loop!) (handle-control-events)
                remove-watch *store :changes
                add-watch *store :changes $ fn (store prev) (render-app!)
                render-app!
                set! js/window.onkeydown handle-key-event
                println |Code-updated.
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
            :features $ #{} :js-ffi
        'render-app! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn render-app! () (; println "|Render app:")
            render-canvas! (comp-container @*store) dispatch!
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.main
          :require
            |@quamolit/quatrefoil-utils :refer $ inject-tree-methods
            quatrefoil.core :refer $ render-canvas! *global-tree init-controls! clear-cache! init-renderer! handle-key-event handle-control-events
            app.comp.container :refer $ comp-container
            app.updater :refer $ [] updater
            |three :as THREE
            touch-control.core :refer $ render-control! control-states start-control-loop! clear-control-loop!
            |mobile-detect :default mobile-detect
            |bottom-tip :default hud!
            quatrefoil.dsl.object3d-dom :refer $ set-perspective-camera!
            |./calcit.build-errors :default build-errors
            js-ffi.browser :refer $ viewport-width viewport-height query-selector
    'app.updater $ %{} 'FileEntry
      :defs $ {} $ 'updater
        %{} 'CodeEntry (:doc |)
          :code $ quote $ defn updater (store op op-data)
            case-default op store $ :states $ update-states store op-data
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] (:: 'Map 'Tag 'Dynamic) 'Dynamic 'Dynamic
            :return $ :: 'Map 'Tag 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.updater
          :require $ quatrefoil.cursor :refer $ update-states
