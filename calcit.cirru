
{}
  :about "|Machine-generated snapshot. Do not edit directly — changes will be overwritten. Use `calcit query` to inspect and `calcit edit`/`calcit tree` to modify. Run `calcit docs agents --contract` before mutations; use `--full` for first orientation or changed contract digest. Manual edits must follow format and schema conventions, then run `calcit edit format`."
  :package |app
  :entries $ {} $ :default
    {} (:description |) (:init-fn 'app.main/main!) (:mode :js) (:reload-fn 'app.main/reload!) (:target :browser)
      :feature-policy $ {}
      :modules $ [] |touch-control/ |pointed-prompt/ |quatrefoil/ |quaternion/ |js-ffi/
      :type-slots $ {}
  :files $ {}
    'app.comp.container $ %{} 'FileEntry
      :defs $ {} $ 'comp-container
        %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-container (store)
            let
                states $ decode-map-as
                    get store :states
                    , .unwrap
                  Map Tag Dynamic
                scaled 0.02
              scene ({})
                group
                  {}
                    :scale $ [] scaled scaled scaled
                    :position $ [] 0 1.2 -0.5
                  comp-multiply $ decode-map-as (>> states :multiply) (Map Tag Dynamic)
                  ambient-light $ {} $ :color 0x666666
                  ; point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                    :position $ [] 20 40 50
                  ; point-light $ {} (:color 0xffffff) (:intensity 2) (:distance 200)
                    :position $ [] 0 60 0
          :examples $ []
          :schema $ quote $ Fn (Map Tag Dynamic) (-> quatrefoil.schema/Component) (:features :js-ffi)
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.container
          :require
            quatrefoil.alias :refer $ group box sphere point-light ambient-light perspective-camera scene text
            quatrefoil.core :refer $ defcomp >>
            app.comp.multiply :refer $ comp-multiply
    'app.comp.multiply $ %{} 'FileEntry
      :defs $ {}
        'ControlValue $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defunion ControlValue Number Bool
          :examples $ []
          :schema $ quote UnionDef
        'as-bool $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn as-bool (value) (decode-map-as value 'Bool)
          :examples $ []
          :schema $ quote $ Fn ControlValue (-> Bool) (:features :js-ffi)
        'as-number $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn as-number (value) (decode-map-as value 'Number)
          :examples $ []
          :schema $ quote $ Fn ControlValue (-> Number) (:features :js-ffi)
        'calc-points $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn calc-points (p0 next times)
            if (<= times 0) ([])
              calc-points-loop ([] p0) (&q* next p0) next $ dec times
          :examples $ []
          :schema $ quote $ Fn quaternion.core/Quaternion quaternion.core/Quaternion Number
            -> $ List quaternion.core/Quaternion
        'calc-points-loop $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn calc-points-loop (acc p next times)
            if (<= times 0) acc $ calc-points-loop (conj acc p) (&q* next p) next $ dec times
          :examples $ []
          :schema $ quote $ Fn (List quaternion.core/Quaternion) quaternion.core/Quaternion quaternion.core/Quaternion Number
            -> $ List quaternion.core/Quaternion
        'comp-labels $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-labels (a-position b-position)
            group ({})
              text $ {} (:text |b) (:size 2) (:depth 0.1) (:position b-position)
                :material $ {} (:kind :mesh-lambert) (:color 0xffcccc) (:opacity 0.9) (:transparent true)
              text $ {} (:text |a) (:size 2) (:depth 0.1) (:position a-position)
                :material $ {} (:kind :mesh-lambert) (:color 0xffcccc) (:opacity 0.9) (:transparent true)
              text $ {} (:text |z) (:size 2) (:depth 0.1)
                :position $ [] 0 0 20
                :material $ {} (:kind :mesh-lambert) (:color 0x664488) (:opacity 0.9) (:transparent true)
              text $ {} (:text |y) (:size 2) (:depth 0.1)
                :position $ [] 0 20 0
                :material $ {} (:kind :mesh-lambert) (:color 0x664488) (:opacity 0.9) (:transparent true)
              text $ {} (:text |x) (:size 2) (:depth 0.1)
                :position $ [] 20 0 0
                :material $ {} (:kind :mesh-lambert) (:color 0x664488) (:opacity 0.9) (:transparent true)
          :examples $ []
          :schema $ quote $ Fn (Tuple Number Number Number) (Tuple Number Number Number) (-> quatrefoil.schema/Component)
        'comp-multiply $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-multiply (states)
            let
                cursor $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                    get states :cursor
                    , .unwrap
                  List Tag
                state $ decode-map-as
                  match (get states :data)
                    (:some found)
                      or found $ {} (:w-ratio 0.4) (:z-base 0) (:z-inc 0) (:z-inc-size 1) (:rotate-inc 1) (:a-w 0) (:rotate-inc-size 1) (:show-labels? true)
                    (:none)
                      {} (:w-ratio 0.4) (:z-base 0) (:z-inc 0) (:z-inc-size 1) (:rotate-inc 1) (:a-w 0) (:rotate-inc-size 1) (:show-labels? true)
                  Map Tag app.comp.multiply/ControlValue
                w-ratio $ as-number $
                  get state :w-ratio
                  , .unwrap
                z-base $ as-number $
                  get state :z-base
                  , .unwrap
                z-inc $ as-number $
                  get state :z-inc
                  , .unwrap
                z-inc-size $ as-number $
                  get state :z-inc-size
                  , .unwrap
                rotate-inc-size $ as-number $
                  get state :rotate-inc-size
                  , .unwrap
                a-w $ as-number $
                  get state :a-w
                  , .unwrap
                show-labels? $ as-bool $
                  get state :show-labels?
                  , .unwrap
                multiplier $ let
                    x 0
                    y 0
                    w w-ratio
                    rest-space $ - 1 (pow x 2) (pow y 2) (pow w 2)
                    z_ $ if (>= rest-space 0) (sqrt rest-space) 0
                  quaternion w x y z_
                scaled-multiplier $ q-scale multiplier 10
              group ({})
                .merge
                  {} (0 element-axis)
                    1 $ quatrefoil.alias/create-element :group ({})
                      ->
                        range $ ceil z-inc-size
                        mapcat $ fn (idx)
                          hint-fn $ Fn Number $ -> (List quatrefoil.schema/Shape)
                          let
                              start $ q+ (quaternion a-w 8 5 z-base)
                                quaternion 0 0 0 $ * z-inc idx
                              points $ calc-points start multiplier $ ceil rotate-inc-size
                            []
                              quatrefoil.alias/create-element :group ({})
                                -> points $ map-indexed $ fn (point-idx p)
                                  comp-point p $ = 0 point-idx
                              line $ {}
                                :points $ map points quaternion-position
                                :position $ [] 0 0 0
                                :material $ {} (:kind :line-dashed) (:color 0xaaaaff) (:opacity 1) (:transparent false)
                    2 $ comp-point scaled-multiplier true
                    4 $ comp-value
                      {} (:speed 0.04) (:show-text? true) (:label |w-ratio) (:value w-ratio)
                        :position $ [] 4 2 12
                        :bound $ [] 0 1
                        :color 0xffff55
                      fn (v1 d!)
                        hint-fn $ Fn Number
                          Fn (List Tag) (Map Tag app.comp.multiply/ControlValue) (-> Unit)
                          -> Unit
                        d! cursor $ assoc state :w-ratio v1
                    5 $ comp-value
                      {} (:speed 1) (:show-text? true) (:label |z-base) (:value z-base)
                        :position $ [] 12 12 1
                        :bound $ [] -20 60
                        :color 0xffff55
                      fn (v1 d!)
                        hint-fn $ Fn Number
                          Fn (List Tag) (Map Tag app.comp.multiply/ControlValue) (-> Unit)
                          -> Unit
                        d! cursor $ assoc state :z-base v1
                    6 $ comp-value
                      {} (:speed 2) (:show-text? true) (:label |a-w) (:value a-w)
                        :position $ [] 12 22 1
                        :bound $ [] 0 20
                        :color 0x77ffcc
                      fn (v1 d!)
                        hint-fn $ Fn Number
                          Fn (List Tag) (Map Tag app.comp.multiply/ControlValue) (-> Unit)
                          -> Unit
                        d! cursor $ assoc state :a-w v1
                    7 $ comp-value
                      {} (:speed 1) (:show-text? true) (:label |z-inc) (:value z-inc)
                        :position $ [] 13 14 4
                        :bound $ [] 0.4 20
                        :color 0xffff55
                      fn (v1 d!)
                        hint-fn $ Fn Number
                          Fn (List Tag) (Map Tag app.comp.multiply/ControlValue) (-> Unit)
                          -> Unit
                        d! cursor $ assoc state :z-inc v1
                    8 $ comp-value
                      {} (:speed 1) (:show-text? true) (:label |z-inc-size) (:value z-inc-size)
                        :position $ [] 18 15 1
                        :bound $ [] 1 6
                        :color 0xff55ff
                      fn (v1 d!)
                        hint-fn $ Fn Number
                          Fn (List Tag) (Map Tag app.comp.multiply/ControlValue) (-> Unit)
                          -> Unit
                        d! cursor $ assoc state :z-inc-size v1
                    9 $ comp-value
                      {} (:speed 2) (:show-text? true) (:label |rotate-inc-size) (:value rotate-inc-size)
                        :position $ [] -4 4 -20
                        :bound $ [] 1 20
                        :color 0xff55ff
                      fn (v1 d!)
                        hint-fn $ Fn Number
                          Fn (List Tag) (Map Tag app.comp.multiply/ControlValue) (-> Unit)
                          -> Unit
                        d! cursor $ assoc state :rotate-inc-size v1
                    10 $ comp-switch
                      {} (:label |labels?) (:color 0x8855ff) (:value show-labels?)
                        :position $ [] 30 0 0
                      fn (v d!)
                        hint-fn $ Fn Bool
                          Fn (List Tag) (Map Tag app.comp.multiply/ControlValue) (-> Unit)
                          -> Unit
                        d! cursor $ assoc state :show-labels? v
                    11 $ point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                      :position $ [] 20 40 50
                  if show-labels?
                    {} $ 3 $ comp-labels
                      quaternion-xyz $ quaternion a-w 8 5 z-base
                      quaternion-xyz scaled-multiplier
                    {} $ 3 nil
          :examples $ []
          :schema $ quote $ Fn (Map Tag Dynamic) (-> quatrefoil.schema/Component) (:features :js-ffi)
        'comp-point $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-point (position first?)
            let
                point $ quaternion-xyz position
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
          :schema $ quote $ Fn quaternion.core/Quaternion Bool (-> quatrefoil.schema/Component) (:features :js-ffi)
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
          :schema $ quote quatrefoil.schema/Shape
        'quaternion-position $ %{} 'CodeEntry
          :doc "|保留原 [x y z scalar] 四项数据，不能直接用作只接受三项的物体 position；渲染位置请用 quaternion-xyz。"
          :code $ quote $ defn quaternion-position (value)
            match value $
              :quaternion s x y z
              [] x y z s
          :examples $ []
          :schema $ quote $ Fn quaternion.core/Quaternion
            -> $ Tuple Number Number Number Number
        'quaternion-s $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn quaternion-s (value)
            match value $
              :quaternion s _x _y _z
              , s
          :examples $ []
          :schema $ quote $ Fn quaternion.core/Quaternion (-> Number)
        'quaternion-xyz $ %{} 'CodeEntry
          :doc "|提取渲染位置所需的三个 Number。四项 [x y z scalar] 数据仍由 quaternion-position 保留。"
          :code $ quote $ defn quaternion-xyz (value)
            match value $
              :quaternion _scalar x y z
              [] x y z
          :examples $ []
          :schema $ quote $ Fn quaternion.core/Quaternion
            -> $ Tuple Number Number Number
          :tests $ [] $ %{} 'TestEntry
            :name |three-dimensional-positions-keep-scalar-separate
            :code $ quote $ let
                q $ quaternion.core/quaternion 9 1 2 3
              assert= ([] 1 2 3)
                quatrefoil.dsl.object3d-dom/read-vec3 $ quaternion-xyz q
              assert= ([] 1 2 3 9) (quaternion-position q)
        'w-hint-fn $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn w-hint-fn (ratio factor)
            [] 0 (* ratio factor) 0
          :examples $ []
          :schema $ quote $ Fn Number Number
            -> $ Tuple Number Number Number
        'zero-point $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def zero-point ([] 0 0 0)
          :examples $ []
          :schema $ quote $ Tuple Number Number Number
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
          :code $ quote $ defref *store
            {} $ :states $ {}
              :cursor $ []
          :examples $ []
          :schema $ quote $ Ref (Map Tag Dynamic)
        'MobileDetectHost $ %{} 'CodeEntry (:doc |)
          :code $ quote $ deftrait MobileDetectHost
            .mobile? $ Fn app.main/MobileDetectHost $ -> Bool
          :examples $ []
          :ffi $ {} (:backend :js) (:kind :external-object) (:target :browser)
            :names $ {} $ :mobile? |mobile
          :schema $ quote Trait
        'dispatch! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn dispatch! (op op-data)
            reset! *store $ cond
                list? op
                updater @*store
                  decode-map-as op $ List Tag
                  decode-map-as op-data $ Map Tag app.comp.multiply/ControlValue
              (and (tag? op) (= op :states))
                let
                    args $ decode-map-as op-data $ Tuple (List Tag) (Map Tag app.comp.multiply/ControlValue)
                  let[] (path state) args $ updater @*store path state
              true @*store
            , &unit
          :examples $ []
          :schema $ quote $ Fn Action Payload (-> Unit) (:generics Action Payload) (:features :js-ffi)
        'main! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn main! () (load-console-formatter!) (inject-tree-methods)
            set-perspective-camera! $ {} (:fov 40) (:near 0.1) (:far 100)
              :position $ [] 0 0 8
              :aspect $ / (viewport-width) (viewport-height)
            let
                canvas-el $
                  query-selector |canvas
                  , .unwrap
              init-renderer! canvas-el $ {} $ :background 0x110022
            render-app!
            add-watch! *store :changes $ fn (store prev) (render-app!)
            set! js/window.onkeydown handle-key-event
            when (mobile?) (render-control!) (handle-control-events)
            init-controls!
            println |App-started!
            , &unit
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :js-ffi)
        'mobile? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn mobile? ()
            let
                detector $ unsafe-coerce (new mobile-detect js/window.navigator.userAgent) app.main/MobileDetectHost
              detector .mobile?
          :examples $ []
          :schema $ quote $ Fn (-> Bool) (:features :js-ffi)
        'reload! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn reload! ()
            if
              not $ nil? build-errors
              hud! |error build-errors
              do (hud! |ok~ nil) (clear-cache!)
                when (mobile?) (clear-control-loop!) (handle-control-events)
                remove-watch! *store :changes
                add-watch! *store :changes $ fn (store prev) (render-app!)
                render-app!
                set! js/window.onkeydown handle-key-event
                println |Code-updated.
            , &unit
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :js-ffi)
        'render-app! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn render-app! () (; println "|Render app:")
            render-canvas! (comp-container @*store) dispatch!
          :examples $ []
          :schema $ quote $ Fn (-> Unit)
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.main
          :require
            quatrefoil.core :refer $ render-canvas! *global-tree init-controls! clear-cache! init-renderer! handle-key-event handle-control-events
            app.comp.container :refer $ comp-container
            |three :as THREE
            touch-control.core :refer $ render-control! start-control-loop! clear-control-loop!
            |mobile-detect :default mobile-detect
            |bottom-tip :default hud!
            quatrefoil.dsl.object3d-dom :refer $ set-perspective-camera!
            |./calcit.build-errors :default build-errors
            js-ffi.browser :refer $ viewport-width viewport-height query-selector
            app.updater :refer $ updater
            |@quatrefoil/utils :refer $ inject-tree-methods
    'app.updater $ %{} 'FileEntry
      :defs $ {} $ 'updater
        %{} 'CodeEntry (:doc |)
          :code $ quote $ defn updater (store path state)
            update-states store $ [] path state
          :examples $ []
          :schema $ quote $ Fn (Map Tag Dynamic) (List Tag) (Map Tag app.comp.multiply/ControlValue)
            -> $ Map Tag Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.updater
          :require $ quatrefoil.cursor :refer $ update-states
