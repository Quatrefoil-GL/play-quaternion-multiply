
{} (:about "|Machine-generated snapshot. Do not edit directly — changes will be overwritten. Use `cr query` to inspect and `cr edit`/`cr tree` to modify. Run `cr docs agents --full` first. Manual edits must follow format and schema conventions, then run `cr edit format`.") (:package |app)
  :entries $ {}
    :default $ {} (:description |) (:init-fn 'app.main/main!) (:mode :native) (:reload-fn 'app.main/reload!)
      :feature-policy $ {}
      :modules $ [] |touch-control/ |pointed-prompt/ |quatrefoil/ |quaternion/
      :type-slots $ {}
  :files $ {}
    |app.comp.container $ %{} 'FileEntry
      :defs $ {}
        |comp-container $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defcomp comp-container (store)
              let
                  states $ :states store
                  cursor $ :cursor states
                  state $ either (:data states)
                    {} $ :tab :portal
                  tab $ :tab state
                  scaled 0.02
                scene ({})
                  group
                    {}
                      :scale $ [] scaled scaled scaled
                      :position $ [] 0 1.2 -0.5
                    comp-multiply $ >> states :multiply
                    ambient-light $ {} (:color 0x666666)
                    ; point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                      :position $ [] 20 40 50
                    ; point-light $ {} (:color 0xffffff) (:intensity 2) (:distance 200)
                      :position $ [] 0 60 0
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns app.comp.container $ :require
            quatrefoil.alias :refer $ group box sphere point-light ambient-light perspective-camera scene text
            quatrefoil.core :refer $ defcomp >>
            app.comp.multiply :refer $ comp-multiply
    |app.comp.multiply $ %{} 'FileEntry
      :defs $ {}
        |comp-fade-rotate $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defcomp comp-fade-rotate () (; "|TODO not in use")
              group ({}) & $ identity
                let
                    inverted-p $ invert multiplier
                    p0 $ q+ ([] 8 5 0 0)
                      v-scale ([] 0 0 6 0) 1
                    p1 $ &q* multiplier p0
                    p2 $ &q* p1 inverted-p
                    points $ [] p0 p1 p2
                  []
                    group ({}) & $ -> points
                      map-indexed $ fn (idx p)
                        comp-point p $ = 0 idx
                    line $ {} (:points points)
                      :position $ [] 0 0 0
                      :material $ {} (:kind :line-dashed) (:color 0xaaaaff) (:opacity 1) (:transparent false)
          :examples $ []
          :schema $ :: 'Dynamic
        |comp-labels $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defcomp comp-labels (a-position b-position)
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
          :schema $ :: 'Dynamic
        |comp-multiply $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defcomp comp-multiply (states)
              let
                  cursor $ :cursor states
                  state $ or (:data states)
                    {} (:w-ratio 0.4) (:z-base 0) (:z-inc 0) (:z-inc-size 1) (:rotate-inc 1) (:a-w 0) (:rotate-inc-size 1) (:show-labels? true)
                  w-ratio $ :w-ratio state
                  z-base $ :z-base state
                  z-inc $ :z-inc state
                  multiplier $ let
                      x 0
                      y 0
                      w w-ratio
                      rest-space $ - 1 (pow x 2) (pow y 2) (pow w 2)
                      z_ $ if (>= rest-space 0) (sqrt rest-space) 0
                    wo-log $ [] x y z_ w
                  calc-points $ fn (p0 next)
                    apply-args
                        []
                        , p0 $ js/Math.ceil (:rotate-inc-size state)
                      fn (acc p n)
                        if (<= n 0) acc $ recur (conj acc p) (&q* next p) (dec n)
                group ({}) element-axis
                  group ({}) & $ ->
                    range $ js/Math.ceil (:z-inc-size state)
                    mapcat $ fn (idx)
                      let
                          points $ calc-points
                            q+
                              [] 8 5 z-base $ :a-w state
                              v-scale ([] 0 0 z-inc 0) idx
                            , multiplier
                        []
                          group ({}) & $ -> points
                            map-indexed $ fn (idx p)
                              comp-point p $ = 0 idx
                          line $ {} (:points points)
                            :position $ [] 0 0 0
                            :material $ {} (:kind :line-dashed) (:color 0xaaaaff) (:opacity 1) (:transparent false)
                  comp-point (v-scale multiplier 10) true
                  if (:show-labels? state)
                    comp-labels
                      [] 8 5 z-base $ :a-w state
                      v-scale multiplier 10
                  comp-value
                    {} (:speed 0.04) (:show-text? true) (:label |w-ratio)
                      :value $ :w-ratio state
                      :position $ [] 4 2 12
                      :bound $ [] 0 1
                      :color 0xffff55
                    fn (v1 d!)
                      d! cursor $ assoc state :w-ratio v1
                  comp-value
                    {} (:speed 1) (:show-text? true) (:label |z-base)
                      :value $ :z-base state
                      :position $ [] 12 12 1
                      :bound $ [] -20 60
                      :color 0xffff55
                    fn (v1 d!)
                      d! cursor $ assoc state :z-base v1
                  comp-value
                    {} (:speed 2) (:show-text? true) (:label |a-w)
                      :value $ :a-w state
                      :position $ [] 12 22 1
                      :bound $ [] 0 20
                      :color 0x77ffcc
                    fn (v1 d!)
                      d! cursor $ assoc state :a-w v1
                  comp-value
                    {} (:speed 1) (:show-text? true) (:label |z-inc)
                      :value $ :z-inc state
                      :position $ [] 13 14 4
                      :bound $ [] 0.4 20
                      :color 0xffff55
                    fn (v1 d!)
                      d! cursor $ assoc state :z-inc v1
                  comp-value
                    {} (:speed 1) (:show-text? true) (:label |z-inc-size)
                      :value $ :z-inc-size state
                      :position $ [] 18 15 1
                      :bound $ [] 1 6
                      :color 0xff55ff
                    fn (v1 d!)
                      d! cursor $ assoc state :z-inc-size v1
                  comp-value
                    {} (:speed 2) (:show-text? true) (:label |rotate-inc-size)
                      :value $ :rotate-inc-size state
                      :position $ [] -4 4 -20
                      :bound $ [] 1 20
                      :color 0xff55ff
                    fn (v1 d!)
                      d! cursor $ assoc state :rotate-inc-size v1
                  comp-switch
                    {} (:label |labels?) (:color 0x8855ff)
                      :value $ :show-labels? state
                      :position $ [] 30 0 0
                    fn (v d!)
                      d! cursor $ assoc state :show-labels? v
                  point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                    :position $ [] 20 40 50
          :examples $ []
          :schema $ :: 'Dynamic
        |comp-point $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defcomp comp-point (position first?)
              group ({})
                sphere $ {} (:radius 0.5) (:position position)
                  :material $ {} (:kind :mesh-standard) (:opacity 0.6) (:transparent true)
                    :color $ if first? 0xffaa88 0xcc88cc
                tube $ {} (:points-fn w-hint-fn)
                  :factor $ last position
                  :radius 0.1
                  :tubularSegments 400
                  :radialSegments 20
                  :position position
                  :material $ {} (:kind :mesh-standard) (:color 0xdd0088) (:opacity 0.6) (:transparent false)
          :examples $ []
          :schema $ :: 'Dynamic
        |element-axis $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def element-axis $ group ({})
              line $ {}
                :points $ [] ([] -20 0 0) zero-point ([] 20 0 0) zero-point ([] 0 20 0) zero-point ([] 0 -20 0)
                :material cover-line
              line $ {}
                :points $ [][] (0 0 20) (0 0 -20)
                :material $ assoc cover-line :color 0xffff99
          :examples $ []
          :schema $ :: 'Dynamic
        |w-hint-fn $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn w-hint-fn (ratio factor)
              [] 0 (* ratio factor) 0
          :examples $ []
          :schema $ :: 'Dynamic
        |zero-point $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def zero-point $ [] 0 0 0
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns app.comp.multiply $ :require
            quatrefoil.alias :refer $ group box sphere text line tube point-light
            quatrefoil.core :refer $ defcomp
            quaternion.core :refer $ q* &q* q+ invert
            quaternion.vector :refer $ v-scale
            quatrefoil.comp.control :refer $ comp-pin-point comp-switch comp-value
            quatrefoil.app.materials :refer $ cover-line
    |app.main $ %{} 'FileEntry
      :defs $ {}
        |*store $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defatom *store $ {}
              :states $ {}
                :cursor $ []
          :examples $ []
          :schema $ :: 'Dynamic
        |dispatch! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn dispatch! (op op-data)
              if (list? op)
                recur :states $ [] op op-data
                let
                    store $ updater @*store op op-data
                  ; js/console.log |Dispatch: op op-data store
                  reset! *store store
          :examples $ []
          :schema $ :: 'Dynamic
        |main! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn main! () (load-console-formatter!) (inject-tree-methods)
              set-perspective-camera! $ {} (:fov 40) (:near 0.1) (:far 100)
                :position $ [] 0 0 8
                :aspect $ / js/window.innerWidth js/window.innerHeight
              let
                  canvas-el $ js/document.querySelector |canvas
                init-renderer! canvas-el $ {} (:background 0x110022)
              render-app!
              add-watch *store :changes $ fn (store prev) (render-app!)
              set! js/window.onkeydown handle-key-event
              when mobile? (render-control!) (handle-control-events)
              init-controls!
              println "|App started!"
          :examples $ []
          :schema $ :: 'Dynamic
        |mobile? $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def mobile? $ .!mobile (new mobile-detect js/window.navigator.userAgent)
          :examples $ []
          :schema $ :: 'Dynamic
        |reload! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn reload! () $ if (some? build-errors) (hud! |error build-errors)
              do (hud! |ok~ nil) (clear-cache!)
                when mobile? (clear-control-loop!) (handle-control-events)
                remove-watch *store :changes
                add-watch *store :changes $ fn (store prev) (render-app!)
                render-app!
                set! js/window.onkeydown handle-key-event
                println "|Code updated."
          :examples $ []
          :schema $ :: 'Dynamic
        |render-app! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn render-app! () (; println "|Render app:")
              render-canvas! (comp-container @*store) dispatch!
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns app.main $ :require
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
    |app.updater $ %{} 'FileEntry
      :defs $ {}
        |updater $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn updater (store op op-data)
              case-default op store $ :states (update-states store op-data)
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns app.updater $ :require
            quatrefoil.cursor :refer $ update-states
