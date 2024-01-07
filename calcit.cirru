
{} (:package |app)
  :configs $ {} (:init-fn |app.main/main!) (:output |src) (:port 6001) (:reload-fn |app.main/reload!) (:storage-key |calcit.cirru) (:version |0.0.1)
    :modules $ [] |respo.calcit/ |lilac/ |memof/ |respo-ui.calcit/ |reel.calcit/ |hud-nav/
  :entries $ {}
  :files $ {}
    |app.comp.container $ %{} :FileEntry
      :defs $ {}
        |comp-container $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1499755354983) (:by nil)
            :data $ {}
              |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |defcomp)
              |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |comp-container)
              |r $ %{} :Expr (:at 1499755354983) (:by nil)
                :data $ {}
                  |T $ %{} :Leaf (:at 1507461830530) (:by |root) (:text |reel)
              |v $ %{} :Expr (:at 1507461832154) (:by |root)
                :data $ {}
                  |D $ %{} :Leaf (:at 1507461833421) (:by |root) (:text |let)
                  |L $ %{} :Expr (:at 1507461834351) (:by |root)
                    :data $ {}
                      |T $ %{} :Expr (:at 1507461834650) (:by |root)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1507461835738) (:by |root) (:text |store)
                          |j $ %{} :Expr (:at 1507461836110) (:by |root)
                            :data $ {}
                              |T $ %{} :Leaf (:at 1507461837276) (:by |root) (:text |:store)
                              |j $ %{} :Leaf (:at 1507461838285) (:by |root) (:text |reel)
                      |j $ %{} :Expr (:at 1509727104820) (:by |root)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1509727105928) (:by |root) (:text |states)
                          |j $ %{} :Expr (:at 1509727106316) (:by |root)
                            :data $ {}
                              |T $ %{} :Leaf (:at 1509727107223) (:by |root) (:text |:states)
                              |j $ %{} :Leaf (:at 1626777497473) (:by |rJG4IHzWf) (:text |store)
                      |n $ %{} :Expr (:at 1584780921790) (:by |rJG4IHzWf)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1584780923771) (:by |rJG4IHzWf) (:text |cursor)
                          |j $ %{} :Expr (:at 1584780991636) (:by |rJG4IHzWf)
                            :data $ {}
                              |D $ %{} :Leaf (:at 1627849325504) (:by |rJG4IHzWf) (:text |or)
                              |T $ %{} :Expr (:at 1584780923944) (:by |rJG4IHzWf)
                                :data $ {}
                                  |T $ %{} :Leaf (:at 1584780925829) (:by |rJG4IHzWf) (:text |:cursor)
                                  |j $ %{} :Leaf (:at 1584780926681) (:by |rJG4IHzWf) (:text |states)
                              |b $ %{} :Expr (:at 1679237728653) (:by |rJG4IHzWf)
                                :data $ {}
                                  |T $ %{} :Leaf (:at 1679237728821) (:by |rJG4IHzWf) (:text |[])
                      |r $ %{} :Expr (:at 1584780887905) (:by |rJG4IHzWf)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1584780889620) (:by |rJG4IHzWf) (:text |state)
                          |j $ %{} :Expr (:at 1584780889933) (:by |rJG4IHzWf)
                            :data $ {}
                              |T $ %{} :Leaf (:at 1627849327831) (:by |rJG4IHzWf) (:text |or)
                              |j $ %{} :Expr (:at 1584780894090) (:by |rJG4IHzWf)
                                :data $ {}
                                  |T $ %{} :Leaf (:at 1584780894689) (:by |rJG4IHzWf) (:text |:data)
                                  |j $ %{} :Leaf (:at 1584780900314) (:by |rJG4IHzWf) (:text |states)
                              |r $ %{} :Expr (:at 1584780901014) (:by |rJG4IHzWf)
                                :data $ {}
                                  |T $ %{} :Leaf (:at 1584780901408) (:by |rJG4IHzWf) (:text |{})
                                  |j $ %{} :Expr (:at 1584780901741) (:by |rJG4IHzWf)
                                    :data $ {}
                                      |T $ %{} :Leaf (:at 1584780906050) (:by |rJG4IHzWf) (:text |:content)
                                      |j $ %{} :Leaf (:at 1584780907617) (:by |rJG4IHzWf) (:text "|\"")
                  |T $ %{} :Expr (:at 1499755354983) (:by nil)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |div)
                      |j $ %{} :Expr (:at 1499755354983) (:by nil)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |{})
                      |q $ %{} :Expr (:at 1700072698846) (:by |rJG4IHzWf)
                        :data $ {}
                          |D $ %{} :Leaf (:at 1700072701950) (:by |rJG4IHzWf) (:text |if-not)
                          |L $ %{} :Leaf (:at 1700072702337) (:by |rJG4IHzWf) (:text |hide-tabs?)
                          |T $ %{} :Expr (:at 1699548514626) (:by |rJG4IHzWf)
                            :data $ {}
                              |T $ %{} :Leaf (:at 1699548519034) (:by |rJG4IHzWf) (:text |comp-hud-nav)
                              |b $ %{} :Expr (:at 1699548541093) (:by |rJG4IHzWf)
                                :data $ {}
                                  |T $ %{} :Leaf (:at 1699548542277) (:by |rJG4IHzWf) (:text |:tab)
                                  |b $ %{} :Leaf (:at 1699548542956) (:by |rJG4IHzWf) (:text |store)
                              |h $ %{} :Leaf (:at 1699548546731) (:by |rJG4IHzWf) (:text |tabs)
                              |l $ %{} :Expr (:at 1699548560792) (:by |rJG4IHzWf)
                                :data $ {}
                                  |T $ %{} :Leaf (:at 1699548561036) (:by |rJG4IHzWf) (:text |fn)
                                  |b $ %{} :Expr (:at 1699548561311) (:by |rJG4IHzWf)
                                    :data $ {}
                                      |T $ %{} :Leaf (:at 1699548565070) (:by |rJG4IHzWf) (:text |next)
                                      |b $ %{} :Leaf (:at 1699548566242) (:by |rJG4IHzWf) (:text |d!)
                                  |h $ %{} :Expr (:at 1699548566683) (:by |rJG4IHzWf)
                                    :data $ {}
                                      |T $ %{} :Leaf (:at 1699548567705) (:by |rJG4IHzWf) (:text |d!)
                                      |b $ %{} :Expr (:at 1699548569093) (:by |rJG4IHzWf)
                                        :data $ {}
                                          |T $ %{} :Leaf (:at 1699548569321) (:by |rJG4IHzWf) (:text |::)
                                          |b $ %{} :Leaf (:at 1699548577981) (:by |rJG4IHzWf) (:text |:tab)
                                          |h $ %{} :Leaf (:at 1699548571517) (:by |rJG4IHzWf) (:text |next)
                      |x $ %{} :Expr (:at 1521954055333) (:by |root)
                        :data $ {}
                          |D $ %{} :Leaf (:at 1521954057510) (:by |root) (:text |when)
                          |L $ %{} :Leaf (:at 1521954059290) (:by |root) (:text |dev?)
                          |T $ %{} :Expr (:at 1507461809635) (:by |root)
                            :data $ {}
                              |T $ %{} :Leaf (:at 1507461815046) (:by |root) (:text |comp-reel)
                              |b $ %{} :Expr (:at 1584780610581) (:by |rJG4IHzWf)
                                :data $ {}
                                  |D $ %{} :Leaf (:at 1584780611347) (:by |rJG4IHzWf) (:text |>>)
                                  |T $ %{} :Leaf (:at 1509727101297) (:by |root) (:text |states)
                                  |j $ %{} :Leaf (:at 1584780613268) (:by |rJG4IHzWf) (:text |:reel)
                              |j $ %{} :Leaf (:at 1507461840459) (:by |root) (:text |reel)
                              |r $ %{} :Expr (:at 1507461840980) (:by |root)
                                :data $ {}
                                  |T $ %{} :Leaf (:at 1507461841342) (:by |root) (:text |{})
      :ns $ %{} :CodeEntry (:doc |)
        :code $ %{} :Expr (:at 1499755354983) (:by nil)
          :data $ {}
            |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |ns)
            |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |app.comp.container)
            |v $ %{} :Expr (:at 1499755354983) (:by nil)
              :data $ {}
                |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |:require)
                |r $ %{} :Expr (:at 1499755354983) (:by nil)
                  :data $ {}
                    |j $ %{} :Leaf (:at 1695659797743) (:by |rJG4IHzWf) (:text |respo-ui.css)
                    |r $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |:as)
                    |v $ %{} :Leaf (:at 1695659799627) (:by |rJG4IHzWf) (:text |css)
                |t $ %{} :Expr (:at 1695659844346) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1695659847085) (:by |rJG4IHzWf) (:text |respo.css)
                    |b $ %{} :Leaf (:at 1695659847949) (:by |rJG4IHzWf) (:text |:refer)
                    |h $ %{} :Expr (:at 1695659848197) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1695659850247) (:by |rJG4IHzWf) (:text |defstyle)
                |v $ %{} :Expr (:at 1499755354983) (:by nil)
                  :data $ {}
                    |j $ %{} :Leaf (:at 1540958704705) (:by |root) (:text |respo.core)
                    |r $ %{} :Leaf (:at 1508946162679) (:by |root) (:text |:refer)
                    |v $ %{} :Expr (:at 1499755354983) (:by nil)
                      :data $ {}
                        |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |defcomp)
                        |l $ %{} :Leaf (:at 1573355389740) (:by |rJG4IHzWf) (:text |defeffect)
                        |r $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |<>)
                        |t $ %{} :Leaf (:at 1584780606618) (:by |rJG4IHzWf) (:text |>>)
                        |v $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |div)
                        |x $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |button)
                        |xT $ %{} :Leaf (:at 1512359490531) (:by |rJG4IHzWf) (:text |textarea)
                        |y $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |span)
                        |yT $ %{} :Leaf (:at 1552321107012) (:by |rJG4IHzWf) (:text |input)
                |x $ %{} :Expr (:at 1499755354983) (:by nil)
                  :data $ {}
                    |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |respo.comp.space)
                    |r $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |:refer)
                    |v $ %{} :Expr (:at 1499755354983) (:by nil)
                      :data $ {}
                        |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |=<)
                |y $ %{} :Expr (:at 1507461845717) (:by |root)
                  :data $ {}
                    |j $ %{} :Leaf (:at 1507461855480) (:by |root) (:text |reel.comp.reel)
                    |r $ %{} :Leaf (:at 1507461856264) (:by |root) (:text |:refer)
                    |v $ %{} :Expr (:at 1507461856484) (:by |root)
                      :data $ {}
                        |j $ %{} :Leaf (:at 1507461858342) (:by |root) (:text |comp-reel)
                |yj $ %{} :Expr (:at 1521954061310) (:by |root)
                  :data $ {}
                    |j $ %{} :Leaf (:at 1527788377809) (:by |root) (:text |app.config)
                    |r $ %{} :Leaf (:at 1521954064826) (:by |root) (:text |:refer)
                    |v $ %{} :Expr (:at 1521954065004) (:by |root)
                      :data $ {}
                        |j $ %{} :Leaf (:at 1521954067604) (:by |root) (:text |dev?)
                        |n $ %{} :Leaf (:at 1700072706257) (:by |rJG4IHzWf) (:text |hide-tabs?)
                |yr $ %{} :Expr (:at 1699810363601) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1699811633981) (:by |rJG4IHzWf) (:text |app.config)
                    |b $ %{} :Leaf (:at 1699810368661) (:by |rJG4IHzWf) (:text |:refer)
                    |h $ %{} :Expr (:at 1699810368958) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1699810370543) (:by |rJG4IHzWf) (:text |tabs)
                |z $ %{} :Expr (:at 1699548477878) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1699548477878) (:by |rJG4IHzWf) (:text |hud-nav.comp)
                    |b $ %{} :Leaf (:at 1699548477878) (:by |rJG4IHzWf) (:text |:refer)
                    |h $ %{} :Expr (:at 1699548477878) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1699548477878) (:by |rJG4IHzWf) (:text |comp-hud-nav)
    |app.config $ %{} :FileEntry
      :defs $ {}
        |default-tab $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1699779561261) (:by |rJG4IHzWf)
            :data $ {}
              |T $ %{} :Leaf (:at 1699779563196) (:by |rJG4IHzWf) (:text |def)
              |b $ %{} :Leaf (:at 1699779561261) (:by |rJG4IHzWf) (:text |default-tab)
              |h $ %{} :Expr (:at 1699779573973) (:by |rJG4IHzWf)
                :data $ {}
                  |D $ %{} :Leaf (:at 1699779575542) (:by |rJG4IHzWf) (:text |turn-tag)
                  |T $ %{} :Expr (:at 1699779561261) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1699779565260) (:by |rJG4IHzWf) (:text |get-env)
                      |b $ %{} :Leaf (:at 1699779567944) (:by |rJG4IHzWf) (:text "|\"tab")
                      |h $ %{} :Expr (:at 1699810321522) (:by |rJG4IHzWf)
                        :data $ {}
                          |D $ %{} :Leaf (:at 1699810324753) (:by |rJG4IHzWf) (:text |turn-string)
                          |T $ %{} :Expr (:at 1699810315319) (:by |rJG4IHzWf)
                            :data $ {}
                              |D $ %{} :Leaf (:at 1699810319219) (:by |rJG4IHzWf) (:text |nth)
                              |T $ %{} :Expr (:at 1699810306448) (:by |rJG4IHzWf)
                                :data $ {}
                                  |D $ %{} :Leaf (:at 1699810312896) (:by |rJG4IHzWf) (:text |last)
                                  |L $ %{} :Leaf (:at 1699810313585) (:by |rJG4IHzWf) (:text |tabs)
                              |b $ %{} :Leaf (:at 1699810336230) (:by |rJG4IHzWf) (:text |0)
        |dev? $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1544873875614) (:by |rJG4IHzWf)
            :data $ {}
              |T $ %{} :Leaf (:at 1544873875614) (:by |rJG4IHzWf) (:text |def)
              |j $ %{} :Leaf (:at 1544873875614) (:by |rJG4IHzWf) (:text |dev?)
              |r $ %{} :Expr (:at 1624469709435) (:by |rJG4IHzWf)
                :data $ {}
                  |5 $ %{} :Leaf (:at 1624469715390) (:by |rJG4IHzWf) (:text |=)
                  |D $ %{} :Leaf (:at 1624469714304) (:by |rJG4IHzWf) (:text "|\"dev")
                  |T $ %{} :Expr (:at 1624469701389) (:by |rJG4IHzWf)
                    :data $ {}
                      |D $ %{} :Leaf (:at 1624469706777) (:by |rJG4IHzWf) (:text |get-env)
                      |T $ %{} :Leaf (:at 1624469708397) (:by |rJG4IHzWf) (:text "|\"mode")
                      |b $ %{} :Leaf (:at 1658121345573) (:by |rJG4IHzWf) (:text "|\"release")
        |hide-tabs? $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1700072678650) (:by |rJG4IHzWf)
            :data $ {}
              |T $ %{} :Leaf (:at 1700072680769) (:by |rJG4IHzWf) (:text |def)
              |b $ %{} :Leaf (:at 1700072678650) (:by |rJG4IHzWf) (:text |hide-tabs?)
              |h $ %{} :Expr (:at 1700072678650) (:by |rJG4IHzWf)
                :data $ {}
                  |T $ %{} :Leaf (:at 1700072681938) (:by |rJG4IHzWf) (:text |=)
                  |b $ %{} :Leaf (:at 1700072683269) (:by |rJG4IHzWf) (:text "|\"true")
                  |h $ %{} :Expr (:at 1700072683976) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1700072686842) (:by |rJG4IHzWf) (:text |get-env)
                      |b $ %{} :Leaf (:at 1700072690268) (:by |rJG4IHzWf) (:text "|\"hide-tabs")
                      |h $ %{} :Leaf (:at 1700072692063) (:by |rJG4IHzWf) (:text |false)
        |site $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1545933382603) (:by |root)
            :data $ {}
              |T $ %{} :Leaf (:at 1518157345496) (:by |root) (:text |def)
              |j $ %{} :Leaf (:at 1518157327696) (:by |root) (:text |site)
              |r $ %{} :Expr (:at 1518157327696) (:by |root)
                :data $ {}
                  |T $ %{} :Leaf (:at 1518157346643) (:by |root) (:text |{})
                  |yf $ %{} :Expr (:at 1544956719115) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1544956719115) (:by |rJG4IHzWf) (:text |:storage-key)
                      |j $ %{} :Leaf (:at 1544956719115) (:by |rJG4IHzWf) (:text "|\"workflow")
        |skip-rendering? $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1700071264060) (:by |rJG4IHzWf)
            :data $ {}
              |T $ %{} :Leaf (:at 1700071264060) (:by |rJG4IHzWf) (:text |def)
              |b $ %{} :Leaf (:at 1700071264060) (:by |rJG4IHzWf) (:text |skip-rendering?)
              |h $ %{} :Expr (:at 1700071279332) (:by |rJG4IHzWf)
                :data $ {}
                  |D $ %{} :Leaf (:at 1700071279767) (:by |rJG4IHzWf) (:text |=)
                  |L $ %{} :Leaf (:at 1700071281354) (:by |rJG4IHzWf) (:text "|\"true")
                  |T $ %{} :Expr (:at 1700071264060) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1700071267174) (:by |rJG4IHzWf) (:text |get-env)
                      |b $ %{} :Leaf (:at 1700071271992) (:by |rJG4IHzWf) (:text "|\"skip")
                      |h $ %{} :Leaf (:at 1700071275246) (:by |rJG4IHzWf) (:text "|\"false")
        |tabs $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1699548547107) (:by |rJG4IHzWf)
            :data $ {}
              |T $ %{} :Leaf (:at 1699548547107) (:by |rJG4IHzWf) (:text |def)
              |b $ %{} :Leaf (:at 1699811617595) (:by |rJG4IHzWf) (:text |tabs)
              |h $ %{} :Expr (:at 1699548547107) (:by |rJG4IHzWf)
                :data $ {}
                  |T $ %{} :Leaf (:at 1699548548668) (:by |rJG4IHzWf) (:text |[])
                  |b $ %{} :Expr (:at 1699548549247) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1699548549451) (:by |rJG4IHzWf) (:text |::)
                      |b $ %{} :Leaf (:at 1699548554126) (:by |rJG4IHzWf) (:text |:fireworks)
                      |h $ %{} :Leaf (:at 1699548557325) (:by |rJG4IHzWf) (:text ||Fireworks)
                      |l $ %{} :Leaf (:at 1699548558878) (:by |rJG4IHzWf) (:text |:dark)
                  |h $ %{} :Expr (:at 1699548549247) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1699548549451) (:by |rJG4IHzWf) (:text |::)
                      |b $ %{} :Leaf (:at 1699553312026) (:by |rJG4IHzWf) (:text |:lorenz)
                      |h $ %{} :Leaf (:at 1699553314825) (:by |rJG4IHzWf) (:text ||Lorenz)
                      |l $ %{} :Leaf (:at 1699548558878) (:by |rJG4IHzWf) (:text |:dark)
                  |j $ %{} :Expr (:at 1699548549247) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1699548549451) (:by |rJG4IHzWf) (:text |::)
                      |b $ %{} :Leaf (:at 1699553321692) (:by |rJG4IHzWf) (:text |:aizawa)
                      |h $ %{} :Leaf (:at 1699553325599) (:by |rJG4IHzWf) (:text ||Aizawa)
                      |l $ %{} :Leaf (:at 1699548558878) (:by |rJG4IHzWf) (:text |:dark)
                  |k $ %{} :Expr (:at 1699548549247) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1699548549451) (:by |rJG4IHzWf) (:text |::)
                      |b $ %{} :Leaf (:at 1699553330156) (:by |rJG4IHzWf) (:text |:fourwing)
                      |h $ %{} :Leaf (:at 1699553333120) (:by |rJG4IHzWf) (:text "||Four Wing")
                      |l $ %{} :Leaf (:at 1699548558878) (:by |rJG4IHzWf) (:text |:dark)
                  |l $ %{} :Expr (:at 1699548549247) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1699548549451) (:by |rJG4IHzWf) (:text |::)
                      |b $ %{} :Leaf (:at 1699551253672) (:by |rJG4IHzWf) (:text |:fractal)
                      |h $ %{} :Leaf (:at 1699551256580) (:by |rJG4IHzWf) (:text ||Fractal)
                      |l $ %{} :Leaf (:at 1699548558878) (:by |rJG4IHzWf) (:text |:dark)
                  |o $ %{} :Expr (:at 1699548549247) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1699548549451) (:by |rJG4IHzWf) (:text |::)
                      |b $ %{} :Leaf (:at 1699776559502) (:by |rJG4IHzWf) (:text |:collision)
                      |h $ %{} :Leaf (:at 1699776562972) (:by |rJG4IHzWf) (:text ||Collision)
                      |l $ %{} :Leaf (:at 1699548558878) (:by |rJG4IHzWf) (:text |:dark)
                  |q $ %{} :Expr (:at 1699548549247) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1699548549451) (:by |rJG4IHzWf) (:text |::)
                      |b $ %{} :Leaf (:at 1699895717018) (:by |rJG4IHzWf) (:text |:bounce)
                      |h $ %{} :Leaf (:at 1699895719384) (:by |rJG4IHzWf) (:text ||Bounce)
                      |l $ %{} :Leaf (:at 1699548558878) (:by |rJG4IHzWf) (:text |:dark)
                  |s $ %{} :Expr (:at 1699548549247) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1699548549451) (:by |rJG4IHzWf) (:text |::)
                      |b $ %{} :Leaf (:at 1700242048779) (:by |rJG4IHzWf) (:text |:feday)
                      |h $ %{} :Leaf (:at 1700241890967) (:by |rJG4IHzWf) (:text ||FEDAY)
                      |l $ %{} :Leaf (:at 1699548558878) (:by |rJG4IHzWf) (:text |:dark)
                  |t $ %{} :Expr (:at 1700503243366) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1700503243775) (:by |rJG4IHzWf) (:text |::)
                      |b $ %{} :Leaf (:at 1700503244842) (:by |rJG4IHzWf) (:text |:bifurcation)
                      |h $ %{} :Leaf (:at 1700503248729) (:by |rJG4IHzWf) (:text "|\"Bifurcation")
                      |l $ %{} :Leaf (:at 1700503251549) (:by |rJG4IHzWf) (:text |:dark)
                  |u $ %{} :Expr (:at 1700503243366) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1700503243775) (:by |rJG4IHzWf) (:text |::)
                      |b $ %{} :Leaf (:at 1700761078243) (:by |rJG4IHzWf) (:text |:ball-spin)
                      |h $ %{} :Leaf (:at 1700761082254) (:by |rJG4IHzWf) (:text "|\"Ball Spin")
                      |l $ %{} :Leaf (:at 1700503251549) (:by |rJG4IHzWf) (:text |:dark)
                  |v $ %{} :Expr (:at 1700503243366) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1700503243775) (:by |rJG4IHzWf) (:text |::)
                      |b $ %{} :Leaf (:at 1701579124569) (:by |rJG4IHzWf) (:text |:lifegame)
                      |h $ %{} :Leaf (:at 1701579128396) (:by |rJG4IHzWf) (:text "|\"Lifegame")
                      |l $ %{} :Leaf (:at 1700503251549) (:by |rJG4IHzWf) (:text |:dark)
                  |w $ %{} :Expr (:at 1700503243366) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1700503243775) (:by |rJG4IHzWf) (:text |::)
                      |b $ %{} :Leaf (:at 1701798866412) (:by |rJG4IHzWf) (:text |:lifegame-trail)
                      |h $ %{} :Leaf (:at 1701798869465) (:by |rJG4IHzWf) (:text "|\"Lifegame Trail")
                      |l $ %{} :Leaf (:at 1700503251549) (:by |rJG4IHzWf) (:text |:dark)
                  |x $ %{} :Expr (:at 1702230361864) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1702230361864) (:by |rJG4IHzWf) (:text |::)
                      |b $ %{} :Leaf (:at 1702230361864) (:by |rJG4IHzWf) (:text |:bounce-trail)
                      |h $ %{} :Leaf (:at 1702230361864) (:by |rJG4IHzWf) (:text "||Bounce Trail")
                      |l $ %{} :Leaf (:at 1702230361864) (:by |rJG4IHzWf) (:text |:dark)
                  |y $ %{} :Expr (:at 1702230361864) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1702230361864) (:by |rJG4IHzWf) (:text |::)
                      |b $ %{} :Leaf (:at 1704090054042) (:by |rJG4IHzWf) (:text |:orbit-spark)
                      |h $ %{} :Leaf (:at 1704090060565) (:by |rJG4IHzWf) (:text "||Orbit Spark")
                      |l $ %{} :Leaf (:at 1702230361864) (:by |rJG4IHzWf) (:text |:dark)
      :ns $ %{} :CodeEntry (:doc |)
        :code $ %{} :Expr (:at 1527788237503) (:by |root)
          :data $ {}
            |T $ %{} :Leaf (:at 1527788237503) (:by |root) (:text |ns)
            |j $ %{} :Leaf (:at 1527788237503) (:by |root) (:text |app.config)
            |n $ %{} :Expr (:at 1699810338569) (:by |rJG4IHzWf)
              :data $ {}
                |T $ %{} :Leaf (:at 1699810339974) (:by |rJG4IHzWf) (:text |:require)
                |b $ %{} :Expr (:at 1699810341728) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1699810344079) (:by |rJG4IHzWf) (:text |app.schema)
                    |b $ %{} :Leaf (:at 1699810352776) (:by |rJG4IHzWf) (:text |:refer)
                    |h $ %{} :Expr (:at 1699810350705) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1699810348828) (:by |rJG4IHzWf) (:text |tabs)
    |app.main $ %{} :FileEntry
      :defs $ {}
        |*instance-renderer $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1699549151317) (:by |rJG4IHzWf)
            :data $ {}
              |T $ %{} :Leaf (:at 1699549152792) (:by |rJG4IHzWf) (:text |defatom)
              |b $ %{} :Leaf (:at 1699549151317) (:by |rJG4IHzWf) (:text |*instance-renderer)
              |h $ %{} :Leaf (:at 1699549154898) (:by |rJG4IHzWf) (:text |nil)
        |*reel $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1499755354983) (:by nil)
            :data $ {}
              |T $ %{} :Leaf (:at 1610792986987) (:by |rJG4IHzWf) (:text |defatom)
              |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |*reel)
              |r $ %{} :Expr (:at 1507399777531) (:by |root)
                :data $ {}
                  |D $ %{} :Leaf (:at 1507399778895) (:by |root) (:text |->)
                  |T $ %{} :Leaf (:at 1507399776350) (:by |root) (:text |reel-schema/reel)
                  |j $ %{} :Expr (:at 1507399779656) (:by |root)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1507399781682) (:by |root) (:text |assoc)
                      |j $ %{} :Leaf (:at 1507401405076) (:by |root) (:text |:base)
                      |r $ %{} :Leaf (:at 1507399787471) (:by |root) (:text |schema/store)
                  |r $ %{} :Expr (:at 1507399779656) (:by |root)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1507399781682) (:by |root) (:text |assoc)
                      |j $ %{} :Leaf (:at 1507399793097) (:by |root) (:text |:store)
                      |r $ %{} :Leaf (:at 1507399787471) (:by |root) (:text |schema/store)
        |*t $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1699549333819) (:by |rJG4IHzWf)
            :data $ {}
              |T $ %{} :Leaf (:at 1699549335181) (:by |rJG4IHzWf) (:text |defatom)
              |b $ %{} :Leaf (:at 1699549333819) (:by |rJG4IHzWf) (:text |*t)
              |h $ %{} :Leaf (:at 1699549337106) (:by |rJG4IHzWf) (:text |0)
        |canvas $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1699549095683) (:by |rJG4IHzWf)
            :data $ {}
              |T $ %{} :Leaf (:at 1699549095683) (:by |rJG4IHzWf) (:text |def)
              |b $ %{} :Leaf (:at 1699549095683) (:by |rJG4IHzWf) (:text |canvas)
              |h $ %{} :Expr (:at 1699549095683) (:by |rJG4IHzWf)
                :data $ {}
                  |T $ %{} :Leaf (:at 1699549106012) (:by |rJG4IHzWf) (:text |js/document.querySelector)
                  |b $ %{} :Leaf (:at 1699549107415) (:by |rJG4IHzWf) (:text "|\"canvas")
        |dispatch! $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1499755354983) (:by nil)
            :data $ {}
              |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |defn)
              |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |dispatch!)
              |r $ %{} :Expr (:at 1499755354983) (:by nil)
                :data $ {}
                  |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |op)
              |t $ %{} :Expr (:at 1547437686766) (:by |root)
                :data $ {}
                  |D $ %{} :Leaf (:at 1547437687530) (:by |root) (:text |when)
                  |L $ %{} :Expr (:at 1584874661674) (:by |rJG4IHzWf)
                    :data $ {}
                      |D $ %{} :Leaf (:at 1584874662518) (:by |rJG4IHzWf) (:text |and)
                      |T $ %{} :Leaf (:at 1547437691006) (:by |root) (:text |config/dev?)
                      |j $ %{} :Expr (:at 1584874663522) (:by |rJG4IHzWf)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1584874664551) (:by |rJG4IHzWf) (:text |not=)
                          |j $ %{} :Leaf (:at 1584874665829) (:by |rJG4IHzWf) (:text |op)
                          |r $ %{} :Leaf (:at 1584874671745) (:by |rJG4IHzWf) (:text |:states)
                  |T $ %{} :Expr (:at 1518156274050) (:by |root)
                    :data $ {}
                      |j $ %{} :Leaf (:at 1692546015701) (:by |rJG4IHzWf) (:text |js/console.log)
                      |r $ %{} :Leaf (:at 1547437698992) (:by |root) (:text "|\"Dispatch:")
                      |v $ %{} :Leaf (:at 1518156280471) (:by |root) (:text |op)
              |v $ %{} :Expr (:at 1584780634192) (:by |rJG4IHzWf)
                :data $ {}
                  |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |reset!)
                  |j $ %{} :Leaf (:at 1507399899641) (:by |root) (:text |*reel)
                  |r $ %{} :Expr (:at 1507399884621) (:by |root)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1507399887573) (:by |root) (:text |reel-updater)
                      |j $ %{} :Leaf (:at 1507399888500) (:by |root) (:text |updater)
                      |r $ %{} :Leaf (:at 1507399891576) (:by |root) (:text |@*reel)
                      |v $ %{} :Leaf (:at 1507399892687) (:by |root) (:text |op)
              |w $ %{} :Expr (:at 1699551268289) (:by |rJG4IHzWf)
                :data $ {}
                  |T $ %{} :Leaf (:at 1699551273449) (:by |rJG4IHzWf) (:text |tag-match)
                  |b $ %{} :Leaf (:at 1699551278048) (:by |rJG4IHzWf) (:text |op)
                  |h $ %{} :Expr (:at 1699551278457) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Expr (:at 1699551278567) (:by |rJG4IHzWf)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1699551280755) (:by |rJG4IHzWf) (:text |:tab)
                          |b $ %{} :Leaf (:at 1699551281330) (:by |rJG4IHzWf) (:text |t)
                      |b $ %{} :Expr (:at 1699551300543) (:by |rJG4IHzWf)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1699551307868) (:by |rJG4IHzWf) (:text |load-renderer)
                          |b $ %{} :Leaf (:at 1699551311669) (:by |rJG4IHzWf) (:text |t)
                  |l $ %{} :Expr (:at 1699551284501) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1699551286230) (:by |rJG4IHzWf) (:text |_)
                      |b $ %{} :Leaf (:at 1699551297337) (:by |rJG4IHzWf) (:text |:ok)
        |load-renderer $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1699550466340) (:by |rJG4IHzWf)
            :data $ {}
              |T $ %{} :Leaf (:at 1699550466340) (:by |rJG4IHzWf) (:text |defn)
              |b $ %{} :Leaf (:at 1699550466340) (:by |rJG4IHzWf) (:text |load-renderer)
              |h $ %{} :Expr (:at 1699550466340) (:by |rJG4IHzWf)
                :data $ {}
                  |T $ %{} :Leaf (:at 1699550470192) (:by |rJG4IHzWf) (:text |tab)
              |j $ %{} :Expr (:at 1699550484042) (:by |rJG4IHzWf)
                :data $ {}
                  |T $ %{} :Leaf (:at 1699550485488) (:by |rJG4IHzWf) (:text |hint-fn)
                  |b $ %{} :Leaf (:at 1699550486264) (:by |rJG4IHzWf) (:text |async)
              |l $ %{} :Expr (:at 1699550945415) (:by |rJG4IHzWf)
                :data $ {}
                  |D $ %{} :Leaf (:at 1699550946228) (:by |rJG4IHzWf) (:text |let)
                  |T $ %{} :Expr (:at 1699550947779) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Expr (:at 1699550948118) (:by |rJG4IHzWf)
                        :data $ {}
                          |D $ %{} :Leaf (:at 1699550950768) (:by |rJG4IHzWf) (:text |renderer)
                          |T $ %{} :Expr (:at 1699550952805) (:by |rJG4IHzWf)
                            :data $ {}
                              |D $ %{} :Leaf (:at 1699550954705) (:by |rJG4IHzWf) (:text |js-await)
                              |T $ %{} :Expr (:at 1699550471071) (:by |rJG4IHzWf)
                                :data $ {}
                                  |T $ %{} :Leaf (:at 1699550473664) (:by |rJG4IHzWf) (:text |case-default)
                                  |b $ %{} :Leaf (:at 1699550474814) (:by |rJG4IHzWf) (:text |tab)
                                  |e $ %{} :Expr (:at 1699550494302) (:by |rJG4IHzWf)
                                    :data $ {}
                                      |T $ %{} :Leaf (:at 1699550494593) (:by |rJG4IHzWf) (:text |do)
                                      |b $ %{} :Expr (:at 1699550499049) (:by |rJG4IHzWf)
                                        :data $ {}
                                          |T $ %{} :Leaf (:at 1699550501434) (:by |rJG4IHzWf) (:text |eprintln)
                                          |b $ %{} :Leaf (:at 1699550506620) (:by |rJG4IHzWf) (:text "|\"unknown tab:")
                                          |h $ %{} :Leaf (:at 1699550504685) (:by |rJG4IHzWf) (:text |tab)
                                      |h $ %{} :Expr (:at 1699550589873) (:by |rJG4IHzWf)
                                        :data $ {}
                                          |T $ %{} :Leaf (:at 1699550589873) (:by |rJG4IHzWf) (:text |loadFireworksRenderer)
                                          |b $ %{} :Leaf (:at 1699550589873) (:by |rJG4IHzWf) (:text |canvas)
                                  |h $ %{} :Expr (:at 1699550475286) (:by |rJG4IHzWf)
                                    :data $ {}
                                      |T $ %{} :Leaf (:at 1699550478302) (:by |rJG4IHzWf) (:text |:fireworks)
                                      |b $ %{} :Expr (:at 1699550479861) (:by |rJG4IHzWf)
                                        :data $ {}
                                          |T $ %{} :Leaf (:at 1699550479861) (:by |rJG4IHzWf) (:text |loadFireworksRenderer)
                                          |b $ %{} :Leaf (:at 1699550479861) (:by |rJG4IHzWf) (:text |canvas)
                                  |l $ %{} :Expr (:at 1699550508889) (:by |rJG4IHzWf)
                                    :data $ {}
                                      |T $ %{} :Leaf (:at 1699553264024) (:by |rJG4IHzWf) (:text |:lorenz)
                                      |b $ %{} :Expr (:at 1699550513811) (:by |rJG4IHzWf)
                                        :data $ {}
                                          |T $ %{} :Leaf (:at 1699553273712) (:by |rJG4IHzWf) (:text |loadLorenzRenderer)
                                          |b $ %{} :Leaf (:at 1699550521292) (:by |rJG4IHzWf) (:text |canvas)
                                  |m $ %{} :Expr (:at 1699550508889) (:by |rJG4IHzWf)
                                    :data $ {}
                                      |T $ %{} :Leaf (:at 1699553264024) (:by |rJG4IHzWf) (:text |:lorenz)
                                      |b $ %{} :Expr (:at 1699550513811) (:by |rJG4IHzWf)
                                        :data $ {}
                                          |T $ %{} :Leaf (:at 1699553273712) (:by |rJG4IHzWf) (:text |loadLorenzRenderer)
                                          |b $ %{} :Leaf (:at 1699550521292) (:by |rJG4IHzWf) (:text |canvas)
                                  |mT $ %{} :Expr (:at 1699550508889) (:by |rJG4IHzWf)
                                    :data $ {}
                                      |T $ %{} :Leaf (:at 1699553296547) (:by |rJG4IHzWf) (:text |:aizawa)
                                      |b $ %{} :Expr (:at 1699550513811) (:by |rJG4IHzWf)
                                        :data $ {}
                                          |T $ %{} :Leaf (:at 1699553301405) (:by |rJG4IHzWf) (:text |loadAizawaRenderer)
                                          |b $ %{} :Leaf (:at 1699550521292) (:by |rJG4IHzWf) (:text |canvas)
                                  |n $ %{} :Expr (:at 1699550508889) (:by |rJG4IHzWf)
                                    :data $ {}
                                      |T $ %{} :Leaf (:at 1699553291395) (:by |rJG4IHzWf) (:text |:fourwing)
                                      |b $ %{} :Expr (:at 1699550513811) (:by |rJG4IHzWf)
                                        :data $ {}
                                          |T $ %{} :Leaf (:at 1699553285590) (:by |rJG4IHzWf) (:text |loadFourwingRenderer)
                                          |b $ %{} :Leaf (:at 1699550521292) (:by |rJG4IHzWf) (:text |canvas)
                                  |o $ %{} :Expr (:at 1699550508889) (:by |rJG4IHzWf)
                                    :data $ {}
                                      |T $ %{} :Leaf (:at 1699550526454) (:by |rJG4IHzWf) (:text |:fractal)
                                      |b $ %{} :Expr (:at 1699550513811) (:by |rJG4IHzWf)
                                        :data $ {}
                                          |T $ %{} :Leaf (:at 1699550534149) (:by |rJG4IHzWf) (:text |loadFractalRenderer)
                                          |b $ %{} :Leaf (:at 1699550521292) (:by |rJG4IHzWf) (:text |canvas)
                                  |q $ %{} :Expr (:at 1699776632588) (:by |rJG4IHzWf)
                                    :data $ {}
                                      |D $ %{} :Leaf (:at 1699776636406) (:by |rJG4IHzWf) (:text |:collision)
                                      |T $ %{} :Expr (:at 1699776630581) (:by |rJG4IHzWf)
                                        :data $ {}
                                          |T $ %{} :Leaf (:at 1699776631280) (:by |rJG4IHzWf) (:text |loadCollisionRenderer)
                                          |b $ %{} :Leaf (:at 1699776638186) (:by |rJG4IHzWf) (:text |canvas)
                                  |s $ %{} :Expr (:at 1699776632588) (:by |rJG4IHzWf)
                                    :data $ {}
                                      |D $ %{} :Leaf (:at 1699895770901) (:by |rJG4IHzWf) (:text |:bounce)
                                      |T $ %{} :Expr (:at 1699776630581) (:by |rJG4IHzWf)
                                        :data $ {}
                                          |T $ %{} :Leaf (:at 1699895931796) (:by |rJG4IHzWf) (:text |loadBounceRenderer)
                                          |b $ %{} :Leaf (:at 1699776638186) (:by |rJG4IHzWf) (:text |canvas)
                                  |sT $ %{} :Expr (:at 1699776632588) (:by |rJG4IHzWf)
                                    :data $ {}
                                      |D $ %{} :Leaf (:at 1702229217287) (:by |rJG4IHzWf) (:text |:bounce-trail)
                                      |T $ %{} :Expr (:at 1699776630581) (:by |rJG4IHzWf)
                                        :data $ {}
                                          |T $ %{} :Leaf (:at 1702229221196) (:by |rJG4IHzWf) (:text |loadBounceTrailRenderer)
                                          |b $ %{} :Leaf (:at 1699776638186) (:by |rJG4IHzWf) (:text |canvas)
                                  |t $ %{} :Expr (:at 1699776632588) (:by |rJG4IHzWf)
                                    :data $ {}
                                      |D $ %{} :Leaf (:at 1700242065156) (:by |rJG4IHzWf) (:text |:feday)
                                      |T $ %{} :Expr (:at 1699776630581) (:by |rJG4IHzWf)
                                        :data $ {}
                                          |T $ %{} :Leaf (:at 1700242069139) (:by |rJG4IHzWf) (:text |loadFedayRenderer)
                                          |b $ %{} :Leaf (:at 1699776638186) (:by |rJG4IHzWf) (:text |canvas)
                                  |u $ %{} :Expr (:at 1700503267636) (:by |rJG4IHzWf)
                                    :data $ {}
                                      |T $ %{} :Leaf (:at 1700503268160) (:by |rJG4IHzWf) (:text |:bifurcation)
                                      |b $ %{} :Expr (:at 1700503269642) (:by |rJG4IHzWf)
                                        :data $ {}
                                          |T $ %{} :Leaf (:at 1700503289207) (:by |rJG4IHzWf) (:text |loadBifurcationRenderer)
                                          |b $ %{} :Leaf (:at 1700503273226) (:by |rJG4IHzWf) (:text |canvas)
                                  |v $ %{} :Expr (:at 1700503267636) (:by |rJG4IHzWf)
                                    :data $ {}
                                      |T $ %{} :Leaf (:at 1700761095208) (:by |rJG4IHzWf) (:text |:ball-spin)
                                      |b $ %{} :Expr (:at 1700503269642) (:by |rJG4IHzWf)
                                        :data $ {}
                                          |T $ %{} :Leaf (:at 1700761099992) (:by |rJG4IHzWf) (:text |loadBallSpinRenderer)
                                          |b $ %{} :Leaf (:at 1700503273226) (:by |rJG4IHzWf) (:text |canvas)
                                  |w $ %{} :Expr (:at 1700503267636) (:by |rJG4IHzWf)
                                    :data $ {}
                                      |T $ %{} :Leaf (:at 1701579199122) (:by |rJG4IHzWf) (:text |:lifegame)
                                      |b $ %{} :Expr (:at 1700503269642) (:by |rJG4IHzWf)
                                        :data $ {}
                                          |T $ %{} :Leaf (:at 1701579203834) (:by |rJG4IHzWf) (:text |loadLifegameRenderer)
                                          |b $ %{} :Leaf (:at 1700503273226) (:by |rJG4IHzWf) (:text |canvas)
                                  |x $ %{} :Expr (:at 1700503267636) (:by |rJG4IHzWf)
                                    :data $ {}
                                      |T $ %{} :Leaf (:at 1701798887249) (:by |rJG4IHzWf) (:text |:lifegame-trail)
                                      |b $ %{} :Expr (:at 1700503269642) (:by |rJG4IHzWf)
                                        :data $ {}
                                          |T $ %{} :Leaf (:at 1701798890686) (:by |rJG4IHzWf) (:text |loadLifegameTrailRenderer)
                                          |b $ %{} :Leaf (:at 1700503273226) (:by |rJG4IHzWf) (:text |canvas)
                                  |y $ %{} :Expr (:at 1704090090422) (:by |rJG4IHzWf)
                                    :data $ {}
                                      |T $ %{} :Leaf (:at 1704090092279) (:by |rJG4IHzWf) (:text |:orbit-spark)
                                      |b $ %{} :Expr (:at 1704090104358) (:by |rJG4IHzWf)
                                        :data $ {}
                                          |T $ %{} :Leaf (:at 1704090115555) (:by |rJG4IHzWf) (:text |loadOrbitSparkRenderer)
                                          |b $ %{} :Leaf (:at 1704090104358) (:by |rJG4IHzWf) (:text |canvas)
                  |b $ %{} :Expr (:at 1699550963724) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1699550964403) (:by |rJG4IHzWf) (:text |reset!)
                      |b $ %{} :Leaf (:at 1699550964403) (:by |rJG4IHzWf) (:text |*instance-renderer)
                      |h $ %{} :Leaf (:at 1699550968711) (:by |rJG4IHzWf) (:text |renderer)
        |loop-renderer! $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1699549258539) (:by |rJG4IHzWf)
            :data $ {}
              |T $ %{} :Leaf (:at 1699549259634) (:by |rJG4IHzWf) (:text |defn)
              |b $ %{} :Leaf (:at 1699549258539) (:by |rJG4IHzWf) (:text |loop-renderer!)
              |h $ %{} :Expr (:at 1699549258539) (:by |rJG4IHzWf)
                :data $ {}
              |l $ %{} :Expr (:at 1699549275649) (:by |rJG4IHzWf)
                :data $ {}
                  |T $ %{} :Leaf (:at 1699549283114) (:by |rJG4IHzWf) (:text |js/setTimeout)
                  |b $ %{} :Expr (:at 1699549284906) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1699549285342) (:by |rJG4IHzWf) (:text |fn)
                      |b $ %{} :Expr (:at 1699549285624) (:by |rJG4IHzWf)
                        :data $ {}
                      |h $ %{} :Expr (:at 1699549291389) (:by |rJG4IHzWf)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1699549299142) (:by |rJG4IHzWf) (:text |js/requestAnimationFrame)
                          |b $ %{} :Expr (:at 1699549301577) (:by |rJG4IHzWf)
                            :data $ {}
                              |T $ %{} :Leaf (:at 1699549301816) (:by |rJG4IHzWf) (:text |fn)
                              |b $ %{} :Expr (:at 1699549302071) (:by |rJG4IHzWf)
                                :data $ {}
                                  |T $ %{} :Leaf (:at 1699549327549) (:by |rJG4IHzWf) (:text |_t)
                              |h $ %{} :Expr (:at 1699549303202) (:by |rJG4IHzWf)
                                :data $ {}
                                  |T $ %{} :Leaf (:at 1699549308061) (:by |rJG4IHzWf) (:text |loop-renderer!)
                      |j $ %{} :Expr (:at 1699549342352) (:by |rJG4IHzWf)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1699549344060) (:by |rJG4IHzWf) (:text |swap!)
                          |b $ %{} :Leaf (:at 1699549346502) (:by |rJG4IHzWf) (:text |*t)
                          |h $ %{} :Leaf (:at 1699549346941) (:by |rJG4IHzWf) (:text |inc)
                      |l $ %{} :Expr (:at 1699549315019) (:by |rJG4IHzWf)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1699549320563) (:by |rJG4IHzWf) (:text |@*instance-renderer)
                          |b $ %{} :Leaf (:at 1699549349038) (:by |rJG4IHzWf) (:text |@*t)
                          |h $ %{} :Leaf (:at 1699814570818) (:by |rJG4IHzWf) (:text |js/window.skipComputing)
                  |h $ %{} :Leaf (:at 1699707668516) (:by |rJG4IHzWf) (:text |20)
        |main! $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1499755354983) (:by nil)
            :data $ {}
              |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |defn)
              |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |main!)
              |r $ %{} :Expr (:at 1499755354983) (:by nil)
                :data $ {}
              |s $ %{} :Expr (:at 1699549079805) (:by |rJG4IHzWf)
                :data $ {}
                  |T $ %{} :Leaf (:at 1699549081940) (:by |rJG4IHzWf) (:text |hint-fn)
                  |b $ %{} :Leaf (:at 1699549082855) (:by |rJG4IHzWf) (:text |async)
              |sT $ %{} :Expr (:at 1699549087828) (:by |rJG4IHzWf)
                :data $ {}
                  |D $ %{} :Leaf (:at 1699549093348) (:by |rJG4IHzWf) (:text |js-await)
                  |T $ %{} :Expr (:at 1699549083833) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1699549084204) (:by |rJG4IHzWf) (:text |setupInitials)
                      |b $ %{} :Leaf (:at 1699549095308) (:by |rJG4IHzWf) (:text |canvas)
              |sj $ %{} :Expr (:at 1699814606394) (:by |rJG4IHzWf)
                :data $ {}
                  |D $ %{} :Leaf (:at 1699814609041) (:by |rJG4IHzWf) (:text |set!)
                  |T $ %{} :Leaf (:at 1699814606871) (:by |rJG4IHzWf) (:text |js/window.skipComputing)
                  |b $ %{} :Leaf (:at 1700071263640) (:by |rJG4IHzWf) (:text |config/skip-rendering?)
              |t $ %{} :Expr (:at 1544874433785) (:by |rJG4IHzWf)
                :data $ {}
                  |T $ %{} :Leaf (:at 1544874434638) (:by |rJG4IHzWf) (:text |println)
                  |j $ %{} :Leaf (:at 1544874509800) (:by |rJG4IHzWf) (:text "|\"Running mode:")
                  |r $ %{} :Expr (:at 1544874440404) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1544874440190) (:by |rJG4IHzWf) (:text |if)
                      |j $ %{} :Leaf (:at 1544874446442) (:by |rJG4IHzWf) (:text |config/dev?)
                      |r $ %{} :Leaf (:at 1544874449063) (:by |rJG4IHzWf) (:text "|\"dev")
                      |v $ %{} :Leaf (:at 1544874452316) (:by |rJG4IHzWf) (:text "|\"release")
              |v $ %{} :Expr (:at 1636914348413) (:by |rJG4IHzWf)
                :data $ {}
                  |T $ %{} :Leaf (:at 1636914349962) (:by |rJG4IHzWf) (:text |if)
                  |j $ %{} :Leaf (:at 1636914351563) (:by |rJG4IHzWf) (:text |config/dev?)
                  |r $ %{} :Expr (:at 1636914352112) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1636914358071) (:by |rJG4IHzWf) (:text |load-console-formatter!)
              |w $ %{} :Expr (:at 1699550910012) (:by |rJG4IHzWf)
                :data $ {}
                  |T $ %{} :Leaf (:at 1699550910012) (:by |rJG4IHzWf) (:text |render-app!)
              |y $ %{} :Expr (:at 1499755354983) (:by nil)
                :data $ {}
                  |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |add-watch)
                  |j $ %{} :Leaf (:at 1507399915531) (:by |root) (:text |*reel)
                  |r $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |:changes)
                  |v $ %{} :Expr (:at 1499755354983) (:by nil)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |fn)
                      |j $ %{} :Expr (:at 1499755354983) (:by nil)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1612280609284) (:by |rJG4IHzWf) (:text |reel)
                          |j $ %{} :Leaf (:at 1612280610651) (:by |rJG4IHzWf) (:text |prev)
                      |r $ %{} :Expr (:at 1499755354983) (:by nil)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |render-app!)
              |yD $ %{} :Expr (:at 1507461684494) (:by |root)
                :data $ {}
                  |T $ %{} :Leaf (:at 1507461739167) (:by |root) (:text |listen-devtools!)
                  |j $ %{} :Leaf (:at 1624007376825) (:by |rJG4IHzWf) (:text ||k)
                  |r $ %{} :Leaf (:at 1507461693919) (:by |root) (:text |dispatch!)
              |yL $ %{} :Expr (:at 1518157357847) (:by |root)
                :data $ {}
                  |L $ %{} :Leaf (:at 1699779623799) (:by |rJG4IHzWf) (:text |;)
                  |j $ %{} :Leaf (:at 1646150136497) (:by |rJG4IHzWf) (:text |js/window.addEventListener)
                  |r $ %{} :Leaf (:at 1518157458163) (:by |root) (:text ||beforeunload)
                  |v $ %{} :Expr (:at 1612344221583) (:by |rJG4IHzWf)
                    :data $ {}
                      |D $ %{} :Leaf (:at 1612344222204) (:by |rJG4IHzWf) (:text |fn)
                      |L $ %{} :Expr (:at 1612344222530) (:by |rJG4IHzWf)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1612344223520) (:by |rJG4IHzWf) (:text |event)
                      |T $ %{} :Expr (:at 1612344224533) (:by |rJG4IHzWf)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1533919515671) (:by |rJG4IHzWf) (:text |persist-storage!)
              |yM $ %{} :Expr (:at 1518157357847) (:by |root)
                :data $ {}
                  |L $ %{} :Leaf (:at 1699779623181) (:by |rJG4IHzWf) (:text |;)
                  |j $ %{} :Leaf (:at 1646150136497) (:by |rJG4IHzWf) (:text |js/window.addEventListener)
                  |r $ %{} :Leaf (:at 1695833113543) (:by |rJG4IHzWf) (:text ||visibilitychange)
                  |v $ %{} :Expr (:at 1612344221583) (:by |rJG4IHzWf)
                    :data $ {}
                      |D $ %{} :Leaf (:at 1612344222204) (:by |rJG4IHzWf) (:text |fn)
                      |L $ %{} :Expr (:at 1612344222530) (:by |rJG4IHzWf)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1612344223520) (:by |rJG4IHzWf) (:text |event)
                      |T $ %{} :Expr (:at 1695833124329) (:by |rJG4IHzWf)
                        :data $ {}
                          |D $ %{} :Leaf (:at 1695833125950) (:by |rJG4IHzWf) (:text |if)
                          |L $ %{} :Expr (:at 1695833126511) (:by |rJG4IHzWf)
                            :data $ {}
                              |D $ %{} :Leaf (:at 1695833145858) (:by |rJG4IHzWf) (:text |=)
                              |L $ %{} :Leaf (:at 1695833179425) (:by |rJG4IHzWf) (:text "|\"hidden")
                              |T $ %{} :Leaf (:at 1695833167249) (:by |rJG4IHzWf) (:text |js/document.visibilityState)
                          |T $ %{} :Expr (:at 1612344224533) (:by |rJG4IHzWf)
                            :data $ {}
                              |T $ %{} :Leaf (:at 1533919515671) (:by |rJG4IHzWf) (:text |persist-storage!)
              |yP $ %{} :Expr (:at 1518157492640) (:by |root)
                :data $ {}
                  |D $ %{} :Leaf (:at 1699779622204) (:by |rJG4IHzWf) (:text |;)
                  |T $ %{} :Leaf (:at 1518157495438) (:by |root) (:text |let)
                  |j $ %{} :Expr (:at 1518157495644) (:by |root)
                    :data $ {}
                      |T $ %{} :Expr (:at 1518157495826) (:by |root)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1518157496930) (:by |root) (:text |raw)
                          |j $ %{} :Expr (:at 1518157497615) (:by |root)
                            :data $ {}
                              |j $ %{} :Leaf (:at 1646150065132) (:by |rJG4IHzWf) (:text |js/localStorage.getItem)
                              |r $ %{} :Expr (:at 1518157506313) (:by |root)
                                :data $ {}
                                  |T $ %{} :Leaf (:at 1544956709260) (:by |rJG4IHzWf) (:text |:storage-key)
                                  |j $ %{} :Leaf (:at 1527788293499) (:by |root) (:text |config/site)
                  |r $ %{} :Expr (:at 1518157514334) (:by |root)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1533919640958) (:by |rJG4IHzWf) (:text |when)
                      |j $ %{} :Expr (:at 1518157515117) (:by |root)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1518157515786) (:by |root) (:text |some?)
                          |j $ %{} :Leaf (:at 1518157516878) (:by |root) (:text |raw)
                      |r $ %{} :Expr (:at 1518157521635) (:by |root)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1518157523818) (:by |root) (:text |dispatch!)
                          |j $ %{} :Expr (:at 1688397806134) (:by |rJG4IHzWf)
                            :data $ {}
                              |D $ %{} :Leaf (:at 1688397806833) (:by |rJG4IHzWf) (:text |::)
                              |T $ %{} :Leaf (:at 1518157669936) (:by |root) (:text |:hydrate-storage)
                              |b $ %{} :Expr (:at 1688397811073) (:by |rJG4IHzWf)
                                :data $ {}
                                  |T $ %{} :Leaf (:at 1688397811073) (:by |rJG4IHzWf) (:text |parse-cirru-edn)
                                  |b $ %{} :Leaf (:at 1688397811073) (:by |rJG4IHzWf) (:text |raw)
              |yT $ %{} :Expr (:at 1499755354983) (:by nil)
                :data $ {}
                  |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |println)
                  |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text "||App started.")
              |zD $ %{} :Expr (:at 1699551078961) (:by |rJG4IHzWf)
                :data $ {}
                  |D $ %{} :Leaf (:at 1699551079688) (:by |rJG4IHzWf) (:text |->)
                  |T $ %{} :Expr (:at 1699550835290) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1699550835290) (:by |rJG4IHzWf) (:text |load-renderer)
                      |b $ %{} :Expr (:at 1699550835290) (:by |rJG4IHzWf)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1699550835290) (:by |rJG4IHzWf) (:text |:tab)
                          |b $ %{} :Expr (:at 1699550835290) (:by |rJG4IHzWf)
                            :data $ {}
                              |T $ %{} :Leaf (:at 1699550835290) (:by |rJG4IHzWf) (:text |:store)
                              |b $ %{} :Leaf (:at 1699550835290) (:by |rJG4IHzWf) (:text |@*reel)
                  |b $ %{} :Expr (:at 1699551080310) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1699551082678) (:by |rJG4IHzWf) (:text |.!then)
                      |b $ %{} :Expr (:at 1699551083028) (:by |rJG4IHzWf)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1699551083272) (:by |rJG4IHzWf) (:text |fn)
                          |b $ %{} :Expr (:at 1699551083533) (:by |rJG4IHzWf)
                            :data $ {}
                              |T $ %{} :Leaf (:at 1699551086127) (:by |rJG4IHzWf) (:text |r)
                          |h $ %{} :Expr (:at 1699551087579) (:by |rJG4IHzWf)
                            :data $ {}
                              |T $ %{} :Leaf (:at 1699551091520) (:by |rJG4IHzWf) (:text |loop-renderer!)
        |mount-target $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1499755354983) (:by nil)
            :data $ {}
              |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |def)
              |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |mount-target)
              |r $ %{} :Expr (:at 1499755354983) (:by nil)
                :data $ {}
                  |j $ %{} :Leaf (:at 1695659910770) (:by |rJG4IHzWf) (:text |js/document.querySelector)
                  |r $ %{} :Leaf (:at 1499755354983) (:by |root) (:text ||.app)
        |persist-storage! $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1533919515671) (:by |rJG4IHzWf)
            :data $ {}
              |T $ %{} :Leaf (:at 1533919517365) (:by |rJG4IHzWf) (:text |defn)
              |j $ %{} :Leaf (:at 1533919515671) (:by |rJG4IHzWf) (:text |persist-storage!)
              |n $ %{} :Expr (:at 1646150052705) (:by |rJG4IHzWf)
                :data $ {}
              |r $ %{} :Expr (:at 1646150152124) (:by |rJG4IHzWf)
                :data $ {}
                  |T $ %{} :Leaf (:at 1695833186592) (:by |rJG4IHzWf) (:text |println)
                  |b $ %{} :Leaf (:at 1695833194980) (:by |rJG4IHzWf) (:text "|\"Saved at")
                  |e $ %{} :Expr (:at 1695833205162) (:by |rJG4IHzWf)
                    :data $ {}
                      |D $ %{} :Leaf (:at 1695833211484) (:by |rJG4IHzWf) (:text |.!toISOString)
                      |T $ %{} :Expr (:at 1695833196620) (:by |rJG4IHzWf)
                        :data $ {}
                          |D $ %{} :Leaf (:at 1695833204629) (:by |rJG4IHzWf) (:text |new)
                          |T $ %{} :Leaf (:at 1695833201386) (:by |rJG4IHzWf) (:text |js/Date)
              |v $ %{} :Expr (:at 1533919515671) (:by |rJG4IHzWf)
                :data $ {}
                  |j $ %{} :Leaf (:at 1646150150852) (:by |rJG4IHzWf) (:text |js/localStorage.setItem)
                  |r $ %{} :Expr (:at 1533919515671) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1544956703087) (:by |rJG4IHzWf) (:text |:storage-key)
                      |j $ %{} :Leaf (:at 1533919515671) (:by |rJG4IHzWf) (:text |config/site)
                  |v $ %{} :Expr (:at 1533919515671) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1624469402829) (:by |rJG4IHzWf) (:text |format-cirru-edn)
                      |j $ %{} :Expr (:at 1533919515671) (:by |rJG4IHzWf)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1533919515671) (:by |rJG4IHzWf) (:text |:store)
                          |j $ %{} :Leaf (:at 1533919515671) (:by |rJG4IHzWf) (:text |@*reel)
        |reload! $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1626201152815) (:by |rJG4IHzWf)
            :data $ {}
              |D $ %{} :Leaf (:at 1626201153853) (:by |rJG4IHzWf) (:text |defn)
              |L $ %{} :Leaf (:at 1626201157449) (:by |rJG4IHzWf) (:text |reload!)
              |P $ %{} :Expr (:at 1626201163076) (:by |rJG4IHzWf)
                :data $ {}
              |R $ %{} :Expr (:at 1699549211032) (:by |rJG4IHzWf)
                :data $ {}
                  |T $ %{} :Leaf (:at 1699549216554) (:by |rJG4IHzWf) (:text |hint-fn)
                  |b $ %{} :Leaf (:at 1699549217464) (:by |rJG4IHzWf) (:text |async)
              |T $ %{} :Expr (:at 1626201191606) (:by |rJG4IHzWf)
                :data $ {}
                  |D $ %{} :Leaf (:at 1626201192115) (:by |rJG4IHzWf) (:text |if)
                  |L $ %{} :Expr (:at 1626201192626) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1626201534497) (:by |rJG4IHzWf) (:text |nil?)
                      |j $ %{} :Leaf (:at 1626201194806) (:by |rJG4IHzWf) (:text |build-errors)
                  |T $ %{} :Expr (:at 1626201164538) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1626201161775) (:by |rJG4IHzWf) (:text |do)
                      |j $ %{} :Expr (:at 1614750747553) (:by |rJG4IHzWf)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1614750747553) (:by |rJG4IHzWf) (:text |remove-watch)
                          |j $ %{} :Leaf (:at 1614750747553) (:by |rJG4IHzWf) (:text |*reel)
                          |r $ %{} :Leaf (:at 1614750747553) (:by |rJG4IHzWf) (:text |:changes)
                      |r $ %{} :Expr (:at 1507461699387) (:by |root)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1507461702453) (:by |root) (:text |clear-cache!)
                      |v $ %{} :Expr (:at 1612280627439) (:by |rJG4IHzWf)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1612280627439) (:by |rJG4IHzWf) (:text |add-watch)
                          |j $ %{} :Leaf (:at 1612280627439) (:by |rJG4IHzWf) (:text |*reel)
                          |r $ %{} :Leaf (:at 1612280627439) (:by |rJG4IHzWf) (:text |:changes)
                          |v $ %{} :Expr (:at 1612280627439) (:by |rJG4IHzWf)
                            :data $ {}
                              |T $ %{} :Leaf (:at 1612280627439) (:by |rJG4IHzWf) (:text |fn)
                              |j $ %{} :Expr (:at 1612280627439) (:by |rJG4IHzWf)
                                :data $ {}
                                  |T $ %{} :Leaf (:at 1612280627439) (:by |rJG4IHzWf) (:text |reel)
                                  |j $ %{} :Leaf (:at 1612280627439) (:by |rJG4IHzWf) (:text |prev)
                              |r $ %{} :Expr (:at 1612280627439) (:by |rJG4IHzWf)
                                :data $ {}
                                  |T $ %{} :Leaf (:at 1612280627439) (:by |rJG4IHzWf) (:text |render-app!)
                      |x $ %{} :Expr (:at 1507461704162) (:by |root)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1507461706990) (:by |root) (:text |reset!)
                          |j $ %{} :Leaf (:at 1507461708965) (:by |root) (:text |*reel)
                          |r $ %{} :Expr (:at 1507461710020) (:by |root)
                            :data $ {}
                              |T $ %{} :Leaf (:at 1507461730190) (:by |root) (:text |refresh-reel)
                              |j $ %{} :Leaf (:at 1507461719097) (:by |root) (:text |@*reel)
                              |r $ %{} :Leaf (:at 1507461721870) (:by |root) (:text |schema/store)
                              |v $ %{} :Leaf (:at 1507461722724) (:by |root) (:text |updater)
                      |xT $ %{} :Expr (:at 1699549191878) (:by |rJG4IHzWf)
                        :data $ {}
                          |D $ %{} :Leaf (:at 1699549193749) (:by |rJG4IHzWf) (:text |js-await)
                          |T $ %{} :Expr (:at 1699549182602) (:by |rJG4IHzWf)
                            :data $ {}
                              |T $ %{} :Leaf (:at 1699550677738) (:by |rJG4IHzWf) (:text |load-renderer)
                              |b $ %{} :Expr (:at 1699550682257) (:by |rJG4IHzWf)
                                :data $ {}
                                  |T $ %{} :Leaf (:at 1699550682884) (:by |rJG4IHzWf) (:text |:tab)
                                  |b $ %{} :Expr (:at 1699550684772) (:by |rJG4IHzWf)
                                    :data $ {}
                                      |T $ %{} :Leaf (:at 1699550685268) (:by |rJG4IHzWf) (:text |:store)
                                      |b $ %{} :Leaf (:at 1699550688397) (:by |rJG4IHzWf) (:text |@*reel)
                      |y $ %{} :Expr (:at 1626777542168) (:by |rJG4IHzWf)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1626777542168) (:by |rJG4IHzWf) (:text |hud!)
                          |j $ %{} :Leaf (:at 1626777542168) (:by |rJG4IHzWf) (:text "|\"ok~")
                          |r $ %{} :Leaf (:at 1679237703306) (:by |rJG4IHzWf) (:text "|\"Ok")
                  |j $ %{} :Expr (:at 1626201203433) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1626290831868) (:by |rJG4IHzWf) (:text |hud!)
                      |b $ %{} :Leaf (:at 1626290930377) (:by |rJG4IHzWf) (:text "|\"error")
                      |j $ %{} :Leaf (:at 1626201209903) (:by |rJG4IHzWf) (:text |build-errors)
        |render-app! $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1499755354983) (:by nil)
            :data $ {}
              |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |defn)
              |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |render-app!)
              |r $ %{} :Expr (:at 1499755354983) (:by nil)
                :data $ {}
              |v $ %{} :Expr (:at 1499755354983) (:by nil)
                :data $ {}
                  |T $ %{} :Leaf (:at 1624469436438) (:by |rJG4IHzWf) (:text |render!)
                  |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |mount-target)
                  |r $ %{} :Expr (:at 1499755354983) (:by nil)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |comp-container)
                      |j $ %{} :Leaf (:at 1507400119272) (:by |root) (:text |@*reel)
                  |v $ %{} :Leaf (:at 1623915174985) (:by |rJG4IHzWf) (:text |dispatch!)
      :ns $ %{} :CodeEntry (:doc |)
        :code $ %{} :Expr (:at 1499755354983) (:by nil)
          :data $ {}
            |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |ns)
            |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |app.main)
            |r $ %{} :Expr (:at 1499755354983) (:by nil)
              :data $ {}
                |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |:require)
                |j $ %{} :Expr (:at 1499755354983) (:by nil)
                  :data $ {}
                    |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |respo.core)
                    |r $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |:refer)
                    |v $ %{} :Expr (:at 1499755354983) (:by nil)
                      :data $ {}
                        |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |render!)
                        |r $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |clear-cache!)
                |v $ %{} :Expr (:at 1499755354983) (:by nil)
                  :data $ {}
                    |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |app.comp.container)
                    |r $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |:refer)
                    |v $ %{} :Expr (:at 1499755354983) (:by nil)
                      :data $ {}
                        |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |comp-container)
                |y $ %{} :Expr (:at 1499755354983) (:by nil)
                  :data $ {}
                    |j $ %{} :Leaf (:at 1508556737455) (:by |root) (:text |app.updater)
                    |r $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |:refer)
                    |v $ %{} :Expr (:at 1499755354983) (:by nil)
                      :data $ {}
                        |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |updater)
                |yT $ %{} :Expr (:at 1499755354983) (:by nil)
                  :data $ {}
                    |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |app.schema)
                    |r $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |:as)
                    |v $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |schema)
                |yj $ %{} :Expr (:at 1507399674125) (:by |root)
                  :data $ {}
                    |j $ %{} :Leaf (:at 1507399678694) (:by |root) (:text |reel.util)
                    |r $ %{} :Leaf (:at 1507399680625) (:by |root) (:text |:refer)
                    |v $ %{} :Expr (:at 1507399680857) (:by |root)
                      :data $ {}
                        |j $ %{} :Leaf (:at 1518156292092) (:by |root) (:text |listen-devtools!)
                |yr $ %{} :Expr (:at 1507399683930) (:by |root)
                  :data $ {}
                    |j $ %{} :Leaf (:at 1507399687162) (:by |root) (:text |reel.core)
                    |r $ %{} :Leaf (:at 1507399688098) (:by |root) (:text |:refer)
                    |v $ %{} :Expr (:at 1507399688322) (:by |root)
                      :data $ {}
                        |j $ %{} :Leaf (:at 1507399691010) (:by |root) (:text |reel-updater)
                        |q $ %{} :Leaf (:at 1518156288482) (:by |root) (:text |refresh-reel)
                |yv $ %{} :Expr (:at 1507399715229) (:by |root)
                  :data $ {}
                    |j $ %{} :Leaf (:at 1507399717674) (:by |root) (:text |reel.schema)
                    |r $ %{} :Leaf (:at 1507399755750) (:by |root) (:text |:as)
                    |v $ %{} :Leaf (:at 1507399757678) (:by |root) (:text |reel-schema)
                |yy $ %{} :Expr (:at 1527788302920) (:by |root)
                  :data $ {}
                    |j $ %{} :Leaf (:at 1527788304925) (:by |root) (:text |app.config)
                    |r $ %{} :Leaf (:at 1527788306048) (:by |root) (:text |:as)
                    |v $ %{} :Leaf (:at 1527788306884) (:by |root) (:text |config)
                |yyT $ %{} :Expr (:at 1626201173819) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1626201180939) (:by |rJG4IHzWf) (:text "|\"./calcit.build-errors")
                    |j $ %{} :Leaf (:at 1626201183958) (:by |rJG4IHzWf) (:text |:default)
                    |r $ %{} :Leaf (:at 1626201187310) (:by |rJG4IHzWf) (:text |build-errors)
                |yyj $ %{} :Expr (:at 1626290808117) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1626290810913) (:by |rJG4IHzWf) (:text "|\"bottom-tip")
                    |j $ %{} :Leaf (:at 1626290816153) (:by |rJG4IHzWf) (:text |:default)
                    |r $ %{} :Leaf (:at 1626290825711) (:by |rJG4IHzWf) (:text |hud!)
                |z $ %{} :Expr (:at 1699548920367) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1699548933086) (:by |rJG4IHzWf) (:text "|\"../src/apps/fireworks")
                    |b $ %{} :Leaf (:at 1699548935286) (:by |rJG4IHzWf) (:text |:refer)
                    |h $ %{} :Expr (:at 1699548935548) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1699549057832) (:by |rJG4IHzWf) (:text |loadFireworksRenderer)
                |z5 $ %{} :Expr (:at 1699548920367) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1699553220765) (:by |rJG4IHzWf) (:text "|\"../src/apps/attractor-aizawa")
                    |b $ %{} :Leaf (:at 1699548935286) (:by |rJG4IHzWf) (:text |:refer)
                    |h $ %{} :Expr (:at 1699548935548) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1699553226738) (:by |rJG4IHzWf) (:text |loadAizawaRenderer)
                |z7 $ %{} :Expr (:at 1699548920367) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1699553232943) (:by |rJG4IHzWf) (:text "|\"../src/apps/attractor-lorenz")
                    |b $ %{} :Leaf (:at 1699548935286) (:by |rJG4IHzWf) (:text |:refer)
                    |h $ %{} :Expr (:at 1699548935548) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1699553237979) (:by |rJG4IHzWf) (:text |loadLorenzRenderer)
                |z8 $ %{} :Expr (:at 1699548920367) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1699553247355) (:by |rJG4IHzWf) (:text "|\"../src/apps/attractor-fourwing")
                    |b $ %{} :Leaf (:at 1699548935286) (:by |rJG4IHzWf) (:text |:refer)
                    |h $ %{} :Expr (:at 1699548935548) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1699553280259) (:by |rJG4IHzWf) (:text |loadFourwingRenderer)
                |z9 $ %{} :Expr (:at 1699548920367) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1699550419801) (:by |rJG4IHzWf) (:text "|\"../src/apps/fractal")
                    |b $ %{} :Leaf (:at 1699548935286) (:by |rJG4IHzWf) (:text |:refer)
                    |h $ %{} :Expr (:at 1699548935548) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1699550424501) (:by |rJG4IHzWf) (:text |loadFractalRenderer)
                |zB $ %{} :Expr (:at 1699776611129) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1699776617659) (:by |rJG4IHzWf) (:text "|\"../src/apps/collision")
                    |b $ %{} :Leaf (:at 1699776619499) (:by |rJG4IHzWf) (:text |:refer)
                    |h $ %{} :Expr (:at 1699776619727) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1699776627338) (:by |rJG4IHzWf) (:text |loadCollisionRenderer)
                |zC $ %{} :Expr (:at 1699776611129) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1699895923012) (:by |rJG4IHzWf) (:text "|\"../src/apps/bounce")
                    |b $ %{} :Leaf (:at 1699776619499) (:by |rJG4IHzWf) (:text |:refer)
                    |h $ %{} :Expr (:at 1699776619727) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1699895927320) (:by |rJG4IHzWf) (:text |loadBounceRenderer)
                |zCD $ %{} :Expr (:at 1699776611129) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1702229230774) (:by |rJG4IHzWf) (:text "|\"../src/apps/bounce-trail")
                    |b $ %{} :Leaf (:at 1699776619499) (:by |rJG4IHzWf) (:text |:refer)
                    |h $ %{} :Expr (:at 1699776619727) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1702229228479) (:by |rJG4IHzWf) (:text |loadBounceTrailRenderer)
                |zCT $ %{} :Expr (:at 1699776611129) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1700242080147) (:by |rJG4IHzWf) (:text "|\"../src/apps/feday")
                    |b $ %{} :Leaf (:at 1699776619499) (:by |rJG4IHzWf) (:text |:refer)
                    |h $ %{} :Expr (:at 1699776619727) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1700242075812) (:by |rJG4IHzWf) (:text |loadFedayRenderer)
                |zCj $ %{} :Expr (:at 1699776611129) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1700503278923) (:by |rJG4IHzWf) (:text "|\"../src/apps/bifurcation")
                    |b $ %{} :Leaf (:at 1699776619499) (:by |rJG4IHzWf) (:text |:refer)
                    |h $ %{} :Expr (:at 1699776619727) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1700503283021) (:by |rJG4IHzWf) (:text |loadBifurcationRenderer)
                |zCr $ %{} :Expr (:at 1699776611129) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1700761108200) (:by |rJG4IHzWf) (:text "|\"../src/apps/ball-spin")
                    |b $ %{} :Leaf (:at 1699776619499) (:by |rJG4IHzWf) (:text |:refer)
                    |h $ %{} :Expr (:at 1699776619727) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1700761104998) (:by |rJG4IHzWf) (:text |loadBallSpinRenderer)
                |zCv $ %{} :Expr (:at 1699776611129) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1701579222203) (:by |rJG4IHzWf) (:text "|\"../src/apps/lifegame")
                    |b $ %{} :Leaf (:at 1699776619499) (:by |rJG4IHzWf) (:text |:refer)
                    |h $ %{} :Expr (:at 1699776619727) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1701579227045) (:by |rJG4IHzWf) (:text |loadLifegameRenderer)
                |zCx $ %{} :Expr (:at 1699776611129) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1701798898873) (:by |rJG4IHzWf) (:text "|\"../src/apps/lifegame-trail")
                    |b $ %{} :Leaf (:at 1699776619499) (:by |rJG4IHzWf) (:text |:refer)
                    |h $ %{} :Expr (:at 1699776619727) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1701798896473) (:by |rJG4IHzWf) (:text |loadLifegameTrailRenderer)
                |zCy $ %{} :Expr (:at 1699776611129) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1704090127422) (:by |rJG4IHzWf) (:text "|\"../src/apps/orbit-spark")
                    |b $ %{} :Leaf (:at 1699776619499) (:by |rJG4IHzWf) (:text |:refer)
                    |h $ %{} :Expr (:at 1699776619727) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1704090122194) (:by |rJG4IHzWf) (:text |loadOrbitSparkRenderer)
                |zD $ %{} :Expr (:at 1699549071462) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1699549074912) (:by |rJG4IHzWf) (:text "|\"../src/index")
                    |b $ %{} :Leaf (:at 1699549075838) (:by |rJG4IHzWf) (:text |:refer)
                    |h $ %{} :Expr (:at 1699549076382) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1699549076595) (:by |rJG4IHzWf) (:text |setupInitials)
    |app.schema $ %{} :FileEntry
      :defs $ {}
        |store $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1499755354983) (:by nil)
            :data $ {}
              |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |def)
              |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |store)
              |r $ %{} :Expr (:at 1499755354983) (:by nil)
                :data $ {}
                  |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |{})
                  |b $ %{} :Expr (:at 1699548534602) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1699548535371) (:by |rJG4IHzWf) (:text |:tab)
                      |b $ %{} :Leaf (:at 1699811259334) (:by |rJG4IHzWf) (:text |default-tab)
                  |j $ %{} :Expr (:at 1499755354983) (:by nil)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |:states)
                      |j $ %{} :Expr (:at 1499755354983) (:by nil)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |{})
                          |j $ %{} :Expr (:at 1584781004285) (:by |rJG4IHzWf)
                            :data $ {}
                              |T $ %{} :Leaf (:at 1584781007054) (:by |rJG4IHzWf) (:text |:cursor)
                              |j $ %{} :Expr (:at 1584781007287) (:by |rJG4IHzWf)
                                :data $ {}
                                  |T $ %{} :Leaf (:at 1584781007486) (:by |rJG4IHzWf) (:text |[])
      :ns $ %{} :CodeEntry (:doc |)
        :code $ %{} :Expr (:at 1499755354983) (:by nil)
          :data $ {}
            |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |ns)
            |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |app.schema)
            |n $ %{} :Expr (:at 1699779585786) (:by |rJG4IHzWf)
              :data $ {}
                |T $ %{} :Leaf (:at 1699779586534) (:by |rJG4IHzWf) (:text |:require)
                |b $ %{} :Expr (:at 1699779587458) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1699779588732) (:by |rJG4IHzWf) (:text |app.config)
                    |X $ %{} :Leaf (:at 1699779590528) (:by |rJG4IHzWf) (:text |:refer)
                    |b $ %{} :Expr (:at 1699779591577) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1699779589094) (:by |rJG4IHzWf) (:text |default-tab)
    |app.updater $ %{} :FileEntry
      :defs $ {}
        |updater $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1499755354983) (:by nil)
            :data $ {}
              |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |defn)
              |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |updater)
              |r $ %{} :Expr (:at 1499755354983) (:by nil)
                :data $ {}
                  |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |store)
                  |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |op)
                  |v $ %{} :Leaf (:at 1519489491135) (:by |root) (:text |op-id)
                  |x $ %{} :Leaf (:at 1519489492110) (:by |root) (:text |op-time)
              |v $ %{} :Expr (:at 1499755354983) (:by nil)
                :data $ {}
                  |T $ %{} :Leaf (:at 1688397777636) (:by |rJG4IHzWf) (:text |tag-match)
                  |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |op)
                  |n $ %{} :Expr (:at 1507399852251) (:by |root)
                    :data $ {}
                      |T $ %{} :Expr (:at 1688397783265) (:by |rJG4IHzWf)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1507399855618) (:by |root) (:text |:states)
                          |b $ %{} :Leaf (:at 1688397785768) (:by |rJG4IHzWf) (:text |cursor)
                          |h $ %{} :Leaf (:at 1688397786090) (:by |rJG4IHzWf) (:text |s)
                      |j $ %{} :Expr (:at 1584874625235) (:by |rJG4IHzWf)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1584874626558) (:by |rJG4IHzWf) (:text |update-states)
                          |j $ %{} :Leaf (:at 1584874628374) (:by |rJG4IHzWf) (:text |store)
                          |r $ %{} :Leaf (:at 1688397788043) (:by |rJG4IHzWf) (:text |cursor)
                          |t $ %{} :Leaf (:at 1688397788324) (:by |rJG4IHzWf) (:text |s)
                  |q $ %{} :Expr (:at 1699548525038) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Expr (:at 1699548525489) (:by |rJG4IHzWf)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1699548526437) (:by |rJG4IHzWf) (:text |:tab)
                          |b $ %{} :Leaf (:at 1699548527653) (:by |rJG4IHzWf) (:text |t)
                      |b $ %{} :Expr (:at 1699548528319) (:by |rJG4IHzWf)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1699548529144) (:by |rJG4IHzWf) (:text |assoc)
                          |b $ %{} :Leaf (:at 1699548529882) (:by |rJG4IHzWf) (:text |store)
                          |h $ %{} :Leaf (:at 1699548530496) (:by |rJG4IHzWf) (:text |:tab)
                          |l $ %{} :Leaf (:at 1699548531064) (:by |rJG4IHzWf) (:text |t)
                  |t $ %{} :Expr (:at 1518157547521) (:by |root)
                    :data $ {}
                      |T $ %{} :Expr (:at 1688397789504) (:by |rJG4IHzWf)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1518157657108) (:by |root) (:text |:hydrate-storage)
                          |b $ %{} :Leaf (:at 1688397790936) (:by |rJG4IHzWf) (:text |data)
                      |j $ %{} :Leaf (:at 1584874637339) (:by |rJG4IHzWf) (:text |data)
                  |u $ %{} :Expr (:at 1688397780767) (:by |rJG4IHzWf)
                    :data $ {}
                      |D $ %{} :Leaf (:at 1688397781225) (:by |rJG4IHzWf) (:text |_)
                      |T $ %{} :Expr (:at 1688397780408) (:by |rJG4IHzWf)
                        :data $ {}
                          |T $ %{} :Leaf (:at 1688397780408) (:by |rJG4IHzWf) (:text |do)
                          |b $ %{} :Expr (:at 1688397780408) (:by |rJG4IHzWf)
                            :data $ {}
                              |T $ %{} :Leaf (:at 1695659902074) (:by |rJG4IHzWf) (:text |eprintln)
                              |b $ %{} :Leaf (:at 1688397780408) (:by |rJG4IHzWf) (:text "|\"unknown op:")
                              |h $ %{} :Leaf (:at 1688397780408) (:by |rJG4IHzWf) (:text |op)
                          |h $ %{} :Leaf (:at 1688397780408) (:by |rJG4IHzWf) (:text |store)
      :ns $ %{} :CodeEntry (:doc |)
        :code $ %{} :Expr (:at 1499755354983) (:by nil)
          :data $ {}
            |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |ns)
            |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |app.updater)
            |r $ %{} :Expr (:at 1584874614885) (:by |rJG4IHzWf)
              :data $ {}
                |T $ %{} :Leaf (:at 1584874616480) (:by |rJG4IHzWf) (:text |:require)
                |j $ %{} :Expr (:at 1584874616720) (:by |rJG4IHzWf)
                  :data $ {}
                    |j $ %{} :Leaf (:at 1584874620034) (:by |rJG4IHzWf) (:text |respo.cursor)
                    |r $ %{} :Leaf (:at 1584874621356) (:by |rJG4IHzWf) (:text |:refer)
                    |v $ %{} :Expr (:at 1584874621524) (:by |rJG4IHzWf)
                      :data $ {}
                        |j $ %{} :Leaf (:at 1584874623096) (:by |rJG4IHzWf) (:text |update-states)
  :ir $ {} (:package |app)
    :files $ {}
      |app.comp.container $ {}
        :defs $ {}
          |comp-container $ %{} :CodeEntry (:doc |)
            :code $ %{} :Expr (:at 1499755354983) (:by nil)
              :data $ {}
                |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |defcomp)
                |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |comp-container)
                |r $ %{} :Expr (:at 1499755354983) (:by nil)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1507461830530) (:by |root) (:text |reel)
                |v $ %{} :Expr (:at 1507461832154) (:by |root)
                  :data $ {}
                    |D $ %{} :Leaf (:at 1507461833421) (:by |root) (:text |let)
                    |L $ %{} :Expr (:at 1507461834351) (:by |root)
                      :data $ {}
                        |T $ %{} :Expr (:at 1507461834650) (:by |root)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1507461835738) (:by |root) (:text |store)
                            |j $ %{} :Expr (:at 1507461836110) (:by |root)
                              :data $ {}
                                |T $ %{} :Leaf (:at 1507461837276) (:by |root) (:text |:store)
                                |j $ %{} :Leaf (:at 1507461838285) (:by |root) (:text |reel)
                        |j $ %{} :Expr (:at 1509727104820) (:by |root)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1509727105928) (:by |root) (:text |states)
                            |j $ %{} :Expr (:at 1509727106316) (:by |root)
                              :data $ {}
                                |T $ %{} :Leaf (:at 1509727107223) (:by |root) (:text |:states)
                                |j $ %{} :Leaf (:at 1626777497473) (:by |rJG4IHzWf) (:text |store)
                        |n $ %{} :Expr (:at 1584780921790) (:by |rJG4IHzWf)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1584780923771) (:by |rJG4IHzWf) (:text |cursor)
                            |j $ %{} :Expr (:at 1584780991636) (:by |rJG4IHzWf)
                              :data $ {}
                                |D $ %{} :Leaf (:at 1627849325504) (:by |rJG4IHzWf) (:text |or)
                                |T $ %{} :Expr (:at 1584780923944) (:by |rJG4IHzWf)
                                  :data $ {}
                                    |T $ %{} :Leaf (:at 1584780925829) (:by |rJG4IHzWf) (:text |:cursor)
                                    |j $ %{} :Leaf (:at 1584780926681) (:by |rJG4IHzWf) (:text |states)
                                |b $ %{} :Expr (:at 1679237728653) (:by |rJG4IHzWf)
                                  :data $ {}
                                    |T $ %{} :Leaf (:at 1679237728821) (:by |rJG4IHzWf) (:text |[])
                        |r $ %{} :Expr (:at 1584780887905) (:by |rJG4IHzWf)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1584780889620) (:by |rJG4IHzWf) (:text |state)
                            |j $ %{} :Expr (:at 1584780889933) (:by |rJG4IHzWf)
                              :data $ {}
                                |T $ %{} :Leaf (:at 1627849327831) (:by |rJG4IHzWf) (:text |or)
                                |j $ %{} :Expr (:at 1584780894090) (:by |rJG4IHzWf)
                                  :data $ {}
                                    |T $ %{} :Leaf (:at 1584780894689) (:by |rJG4IHzWf) (:text |:data)
                                    |j $ %{} :Leaf (:at 1584780900314) (:by |rJG4IHzWf) (:text |states)
                                |r $ %{} :Expr (:at 1584780901014) (:by |rJG4IHzWf)
                                  :data $ {}
                                    |T $ %{} :Leaf (:at 1584780901408) (:by |rJG4IHzWf) (:text |{})
                                    |j $ %{} :Expr (:at 1584780901741) (:by |rJG4IHzWf)
                                      :data $ {}
                                        |T $ %{} :Leaf (:at 1584780906050) (:by |rJG4IHzWf) (:text |:content)
                                        |j $ %{} :Leaf (:at 1584780907617) (:by |rJG4IHzWf) (:text "|\"")
                    |T $ %{} :Expr (:at 1499755354983) (:by nil)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |div)
                        |j $ %{} :Expr (:at 1499755354983) (:by nil)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |{})
                            |j $ %{} :Expr (:at 1499755354983) (:by nil)
                              :data $ {}
                                |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |:style)
                                |j $ %{} :Expr (:at 1499755354983) (:by nil)
                                  :data $ {}
                                    |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |merge)
                                    |j $ %{} :Leaf (:at 1521129814235) (:by |root) (:text |ui/global)
                                    |r $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |ui/row)
                        |n $ %{} :Expr (:at 1512359496483) (:by |rJG4IHzWf)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1552321295613) (:by |rJG4IHzWf) (:text |textarea)
                            |j $ %{} :Expr (:at 1512359504511) (:by |rJG4IHzWf)
                              :data $ {}
                                |T $ %{} :Leaf (:at 1512359504843) (:by |rJG4IHzWf) (:text |{})
                                |j $ %{} :Expr (:at 1512359505095) (:by |rJG4IHzWf)
                                  :data $ {}
                                    |T $ %{} :Leaf (:at 1512359505740) (:by |rJG4IHzWf) (:text |:value)
                                    |j $ %{} :Expr (:at 1512359518303) (:by |rJG4IHzWf)
                                      :data $ {}
                                        |T $ %{} :Leaf (:at 1512359519072) (:by |rJG4IHzWf) (:text |:content)
                                        |j $ %{} :Leaf (:at 1584780914332) (:by |rJG4IHzWf) (:text |state)
                                |n $ %{} :Expr (:at 1512359562842) (:by |rJG4IHzWf)
                                  :data $ {}
                                    |T $ %{} :Leaf (:at 1512359565393) (:by |rJG4IHzWf) (:text |:placeholder)
                                    |j $ %{} :Leaf (:at 1626201966743) (:by |rJG4IHzWf) (:text "|\"Content")
                                |p $ %{} :Expr (:at 1512359616676) (:by |rJG4IHzWf)
                                  :data $ {}
                                    |T $ %{} :Leaf (:at 1512359618050) (:by |rJG4IHzWf) (:text |:style)
                                    |j $ %{} :Expr (:at 1512359674211) (:by |rJG4IHzWf)
                                      :data $ {}
                                        |D $ %{} :Leaf (:at 1512359675059) (:by |rJG4IHzWf) (:text |merge)
                                        |L $ %{} :Leaf (:at 1555609489873) (:by |rJG4IHzWf) (:text |ui/expand)
                                        |T $ %{} :Leaf (:at 1512359621430) (:by |rJG4IHzWf) (:text |ui/textarea)
                                        |j $ %{} :Expr (:at 1512359675605) (:by |rJG4IHzWf)
                                          :data $ {}
                                            |T $ %{} :Leaf (:at 1512359676048) (:by |rJG4IHzWf) (:text |{})
                                            |r $ %{} :Expr (:at 1512359678671) (:by |rJG4IHzWf)
                                              :data $ {}
                                                |T $ %{} :Leaf (:at 1512359679785) (:by |rJG4IHzWf) (:text |:height)
                                                |j $ %{} :Leaf (:at 1574608185129) (:by |rJG4IHzWf) (:text |320)
                                |r $ %{} :Expr (:at 1512359551423) (:by |rJG4IHzWf)
                                  :data $ {}
                                    |T $ %{} :Leaf (:at 1515731637149) (:by |root) (:text |:on-input)
                                    |r $ %{} :Expr (:at 1573355456413) (:by |rJG4IHzWf)
                                      :data $ {}
                                        |D $ %{} :Leaf (:at 1573355458962) (:by |rJG4IHzWf) (:text |fn)
                                        |L $ %{} :Expr (:at 1573355459236) (:by |rJG4IHzWf)
                                          :data $ {}
                                            |T $ %{} :Leaf (:at 1573355459482) (:by |rJG4IHzWf) (:text |e)
                                            |j $ %{} :Leaf (:at 1573355459980) (:by |rJG4IHzWf) (:text |d!)
                                        |T $ %{} :Expr (:at 1515731639686) (:by |root)
                                          :data $ {}
                                            |T $ %{} :Leaf (:at 1573355463209) (:by |rJG4IHzWf) (:text |d!)
                                            |r $ %{} :Leaf (:at 1584780918978) (:by |rJG4IHzWf) (:text |cursor)
                                            |v $ %{} :Expr (:at 1584780929603) (:by |rJG4IHzWf)
                                              :data $ {}
                                                |D $ %{} :Leaf (:at 1584780932163) (:by |rJG4IHzWf) (:text |assoc)
                                                |L $ %{} :Leaf (:at 1584780932805) (:by |rJG4IHzWf) (:text |state)
                                                |P $ %{} :Leaf (:at 1584780935039) (:by |rJG4IHzWf) (:text |:content)
                                                |T $ %{} :Expr (:at 1512359558827) (:by |rJG4IHzWf)
                                                  :data $ {}
                                                    |T $ %{} :Leaf (:at 1512359559399) (:by |rJG4IHzWf) (:text |:value)
                                                    |j $ %{} :Leaf (:at 1573355472480) (:by |rJG4IHzWf) (:text |e)
                        |r $ %{} :Expr (:at 1499755354983) (:by nil)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |=<)
                            |j $ %{} :Leaf (:at 1584875384898) (:by |rJG4IHzWf) (:text |8)
                            |r $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |nil)
                        |v $ %{} :Expr (:at 1499755354983) (:by nil)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |div)
                            |f $ %{} :Expr (:at 1512359526483) (:by |rJG4IHzWf)
                              :data $ {}
                                |T $ %{} :Leaf (:at 1512359526843) (:by |rJG4IHzWf) (:text |{})
                                |j $ %{} :Expr (:at 1535563521753) (:by |rJG4IHzWf)
                                  :data $ {}
                                    |T $ %{} :Leaf (:at 1535563522569) (:by |rJG4IHzWf) (:text |:style)
                                    |j $ %{} :Leaf (:at 1555609487202) (:by |rJG4IHzWf) (:text |ui/expand)
                            |l $ %{} :Expr (:at 1519699101175) (:by |root)
                              :data $ {}
                                |T $ %{} :Leaf (:at 1519699101706) (:by |root) (:text |comp-md)
                                |j $ %{} :Leaf (:at 1596818901713) (:by |rJG4IHzWf) (:text "||This is some content with `code`")
                            |o $ %{} :Expr (:at 1499755354983) (:by nil)
                              :data $ {}
                                |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |=<)
                                |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text ||8px)
                                |r $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |nil)
                            |r $ %{} :Expr (:at 1499755354983) (:by nil)
                              :data $ {}
                                |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |button)
                                |j $ %{} :Expr (:at 1499755354983) (:by nil)
                                  :data $ {}
                                    |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |{})
                                    |j $ %{} :Expr (:at 1499755354983) (:by nil)
                                      :data $ {}
                                        |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |:style)
                                        |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |ui/button)
                                    |r $ %{} :Expr (:at 1499755354983) (:by nil)
                                      :data $ {}
                                        |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |:inner-text)
                                        |j $ %{} :Leaf (:at 1584875392985) (:by |rJG4IHzWf) (:text "|\"Run")
                                    |v $ %{} :Expr (:at 1499755354983) (:by nil)
                                      :data $ {}
                                        |T $ %{} :Leaf (:at 1515731664266) (:by |root) (:text |:on-click)
                                        |j $ %{} :Expr (:at 1512359578073) (:by |rJG4IHzWf)
                                          :data $ {}
                                            |T $ %{} :Leaf (:at 1512359578445) (:by |rJG4IHzWf) (:text |fn)
                                            |j $ %{} :Expr (:at 1512359578681) (:by |rJG4IHzWf)
                                              :data $ {}
                                                |T $ %{} :Leaf (:at 1512359578853) (:by |rJG4IHzWf) (:text |e)
                                                |j $ %{} :Leaf (:at 1512359579539) (:by |rJG4IHzWf) (:text |d!)
                                            |r $ %{} :Expr (:at 1512359581078) (:by |rJG4IHzWf)
                                              :data $ {}
                                                |T $ %{} :Leaf (:at 1512359582042) (:by |rJG4IHzWf) (:text |println)
                                                |j $ %{} :Expr (:at 1512359587492) (:by |rJG4IHzWf)
                                                  :data $ {}
                                                    |T $ %{} :Leaf (:at 1512359588770) (:by |rJG4IHzWf) (:text |:content)
                                                    |j $ %{} :Leaf (:at 1584780962830) (:by |rJG4IHzWf) (:text |state)
                        |x $ %{} :Expr (:at 1521954055333) (:by |root)
                          :data $ {}
                            |D $ %{} :Leaf (:at 1521954057510) (:by |root) (:text |when)
                            |L $ %{} :Leaf (:at 1521954059290) (:by |root) (:text |dev?)
                            |T $ %{} :Expr (:at 1507461809635) (:by |root)
                              :data $ {}
                                |T $ %{} :Leaf (:at 1507461815046) (:by |root) (:text |comp-reel)
                                |b $ %{} :Expr (:at 1584780610581) (:by |rJG4IHzWf)
                                  :data $ {}
                                    |D $ %{} :Leaf (:at 1584780611347) (:by |rJG4IHzWf) (:text |>>)
                                    |T $ %{} :Leaf (:at 1509727101297) (:by |root) (:text |states)
                                    |j $ %{} :Leaf (:at 1584780613268) (:by |rJG4IHzWf) (:text |:reel)
                                |j $ %{} :Leaf (:at 1507461840459) (:by |root) (:text |reel)
                                |r $ %{} :Expr (:at 1507461840980) (:by |root)
                                  :data $ {}
                                    |T $ %{} :Leaf (:at 1507461841342) (:by |root) (:text |{})
        :ns $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1499755354983) (:by nil)
            :data $ {}
              |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |ns)
              |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |app.comp.container)
              |v $ %{} :Expr (:at 1499755354983) (:by nil)
                :data $ {}
                  |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |:require)
                  |r $ %{} :Expr (:at 1499755354983) (:by nil)
                    :data $ {}
                      |j $ %{} :Leaf (:at 1516527080962) (:by |root) (:text |respo-ui.core)
                      |r $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |:as)
                      |v $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |ui)
                  |v $ %{} :Expr (:at 1499755354983) (:by nil)
                    :data $ {}
                      |j $ %{} :Leaf (:at 1540958704705) (:by |root) (:text |respo.core)
                      |r $ %{} :Leaf (:at 1508946162679) (:by |root) (:text |:refer)
                      |v $ %{} :Expr (:at 1499755354983) (:by nil)
                        :data $ {}
                          |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |defcomp)
                          |l $ %{} :Leaf (:at 1573355389740) (:by |rJG4IHzWf) (:text |defeffect)
                          |r $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |<>)
                          |t $ %{} :Leaf (:at 1584780606618) (:by |rJG4IHzWf) (:text |>>)
                          |v $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |div)
                          |x $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |button)
                          |xT $ %{} :Leaf (:at 1512359490531) (:by |rJG4IHzWf) (:text |textarea)
                          |y $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |span)
                          |yT $ %{} :Leaf (:at 1552321107012) (:by |rJG4IHzWf) (:text |input)
                  |x $ %{} :Expr (:at 1499755354983) (:by nil)
                    :data $ {}
                      |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |respo.comp.space)
                      |r $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |:refer)
                      |v $ %{} :Expr (:at 1499755354983) (:by nil)
                        :data $ {}
                          |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |=<)
                  |y $ %{} :Expr (:at 1507461845717) (:by |root)
                    :data $ {}
                      |j $ %{} :Leaf (:at 1507461855480) (:by |root) (:text |reel.comp.reel)
                      |r $ %{} :Leaf (:at 1507461856264) (:by |root) (:text |:refer)
                      |v $ %{} :Expr (:at 1507461856484) (:by |root)
                        :data $ {}
                          |j $ %{} :Leaf (:at 1507461858342) (:by |root) (:text |comp-reel)
                  |yT $ %{} :Expr (:at 1519699088529) (:by |root)
                    :data $ {}
                      |j $ %{} :Leaf (:at 1519699092590) (:by |root) (:text |respo-md.comp.md)
                      |r $ %{} :Leaf (:at 1519699093410) (:by |root) (:text |:refer)
                      |v $ %{} :Expr (:at 1519699093683) (:by |root)
                        :data $ {}
                          |j $ %{} :Leaf (:at 1519699096732) (:by |root) (:text |comp-md)
                  |yj $ %{} :Expr (:at 1521954061310) (:by |root)
                    :data $ {}
                      |j $ %{} :Leaf (:at 1527788377809) (:by |root) (:text |app.config)
                      |r $ %{} :Leaf (:at 1521954064826) (:by |root) (:text |:refer)
                      |v $ %{} :Expr (:at 1521954065004) (:by |root)
                        :data $ {}
                          |j $ %{} :Leaf (:at 1521954067604) (:by |root) (:text |dev?)
      |app.config $ {}
        :defs $ {}
          |dev? $ %{} :CodeEntry (:doc |)
            :code $ %{} :Expr (:at 1544873875614) (:by |rJG4IHzWf)
              :data $ {}
                |T $ %{} :Leaf (:at 1544873875614) (:by |rJG4IHzWf) (:text |def)
                |j $ %{} :Leaf (:at 1544873875614) (:by |rJG4IHzWf) (:text |dev?)
                |r $ %{} :Expr (:at 1624469709435) (:by |rJG4IHzWf)
                  :data $ {}
                    |5 $ %{} :Leaf (:at 1624469715390) (:by |rJG4IHzWf) (:text |=)
                    |D $ %{} :Leaf (:at 1624469714304) (:by |rJG4IHzWf) (:text "|\"dev")
                    |T $ %{} :Expr (:at 1624469701389) (:by |rJG4IHzWf)
                      :data $ {}
                        |D $ %{} :Leaf (:at 1624469706777) (:by |rJG4IHzWf) (:text |get-env)
                        |T $ %{} :Leaf (:at 1624469708397) (:by |rJG4IHzWf) (:text "|\"mode")
                        |b $ %{} :Leaf (:at 1658121345573) (:by |rJG4IHzWf) (:text "|\"release")
          |site $ %{} :CodeEntry (:doc |)
            :code $ %{} :Expr (:at 1545933382603) (:by |root)
              :data $ {}
                |T $ %{} :Leaf (:at 1518157345496) (:by |root) (:text |def)
                |j $ %{} :Leaf (:at 1518157327696) (:by |root) (:text |site)
                |r $ %{} :Expr (:at 1518157327696) (:by |root)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1518157346643) (:by |root) (:text |{})
                    |yf $ %{} :Expr (:at 1544956719115) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1544956719115) (:by |rJG4IHzWf) (:text |:storage-key)
                        |j $ %{} :Leaf (:at 1544956719115) (:by |rJG4IHzWf) (:text "|\"workflow")
        :ns $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1527788237503) (:by |root)
            :data $ {}
              |T $ %{} :Leaf (:at 1527788237503) (:by |root) (:text |ns)
              |j $ %{} :Leaf (:at 1527788237503) (:by |root) (:text |app.config)
      |app.main $ {}
        :defs $ {}
          |*reel $ %{} :CodeEntry (:doc |)
            :code $ %{} :Expr (:at 1499755354983) (:by nil)
              :data $ {}
                |T $ %{} :Leaf (:at 1610792986987) (:by |rJG4IHzWf) (:text |defatom)
                |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |*reel)
                |r $ %{} :Expr (:at 1507399777531) (:by |root)
                  :data $ {}
                    |D $ %{} :Leaf (:at 1507399778895) (:by |root) (:text |->)
                    |T $ %{} :Leaf (:at 1507399776350) (:by |root) (:text |reel-schema/reel)
                    |j $ %{} :Expr (:at 1507399779656) (:by |root)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1507399781682) (:by |root) (:text |assoc)
                        |j $ %{} :Leaf (:at 1507401405076) (:by |root) (:text |:base)
                        |r $ %{} :Leaf (:at 1507399787471) (:by |root) (:text |schema/store)
                    |r $ %{} :Expr (:at 1507399779656) (:by |root)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1507399781682) (:by |root) (:text |assoc)
                        |j $ %{} :Leaf (:at 1507399793097) (:by |root) (:text |:store)
                        |r $ %{} :Leaf (:at 1507399787471) (:by |root) (:text |schema/store)
          |dispatch! $ %{} :CodeEntry (:doc |)
            :code $ %{} :Expr (:at 1499755354983) (:by nil)
              :data $ {}
                |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |defn)
                |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |dispatch!)
                |r $ %{} :Expr (:at 1499755354983) (:by nil)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |op)
                |t $ %{} :Expr (:at 1547437686766) (:by |root)
                  :data $ {}
                    |D $ %{} :Leaf (:at 1547437687530) (:by |root) (:text |when)
                    |L $ %{} :Expr (:at 1584874661674) (:by |rJG4IHzWf)
                      :data $ {}
                        |D $ %{} :Leaf (:at 1584874662518) (:by |rJG4IHzWf) (:text |and)
                        |T $ %{} :Leaf (:at 1547437691006) (:by |root) (:text |config/dev?)
                        |j $ %{} :Expr (:at 1584874663522) (:by |rJG4IHzWf)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1584874664551) (:by |rJG4IHzWf) (:text |not=)
                            |j $ %{} :Leaf (:at 1584874665829) (:by |rJG4IHzWf) (:text |op)
                            |r $ %{} :Leaf (:at 1584874671745) (:by |rJG4IHzWf) (:text |:states)
                    |T $ %{} :Expr (:at 1518156274050) (:by |root)
                      :data $ {}
                        |j $ %{} :Leaf (:at 1518156276516) (:by |root) (:text |println)
                        |r $ %{} :Leaf (:at 1547437698992) (:by |root) (:text "|\"Dispatch:")
                        |v $ %{} :Leaf (:at 1518156280471) (:by |root) (:text |op)
                |v $ %{} :Expr (:at 1584780634192) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |reset!)
                    |j $ %{} :Leaf (:at 1507399899641) (:by |root) (:text |*reel)
                    |r $ %{} :Expr (:at 1507399884621) (:by |root)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1507399887573) (:by |root) (:text |reel-updater)
                        |j $ %{} :Leaf (:at 1507399888500) (:by |root) (:text |updater)
                        |r $ %{} :Leaf (:at 1507399891576) (:by |root) (:text |@*reel)
                        |v $ %{} :Leaf (:at 1507399892687) (:by |root) (:text |op)
          |main! $ %{} :CodeEntry (:doc |)
            :code $ %{} :Expr (:at 1499755354983) (:by nil)
              :data $ {}
                |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |defn)
                |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |main!)
                |r $ %{} :Expr (:at 1499755354983) (:by nil)
                  :data $ {}
                |t $ %{} :Expr (:at 1544874433785) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1544874434638) (:by |rJG4IHzWf) (:text |println)
                    |j $ %{} :Leaf (:at 1544874509800) (:by |rJG4IHzWf) (:text "|\"Running mode:")
                    |r $ %{} :Expr (:at 1544874440404) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1544874440190) (:by |rJG4IHzWf) (:text |if)
                        |j $ %{} :Leaf (:at 1544874446442) (:by |rJG4IHzWf) (:text |config/dev?)
                        |r $ %{} :Leaf (:at 1544874449063) (:by |rJG4IHzWf) (:text "|\"dev")
                        |v $ %{} :Leaf (:at 1544874452316) (:by |rJG4IHzWf) (:text "|\"release")
                |v $ %{} :Expr (:at 1636914348413) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1636914349962) (:by |rJG4IHzWf) (:text |if)
                    |j $ %{} :Leaf (:at 1636914351563) (:by |rJG4IHzWf) (:text |config/dev?)
                    |r $ %{} :Expr (:at 1636914352112) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1636914358071) (:by |rJG4IHzWf) (:text |load-console-formatter!)
                |x $ %{} :Expr (:at 1499755354983) (:by nil)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |render-app!)
                |y $ %{} :Expr (:at 1499755354983) (:by nil)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |add-watch)
                    |j $ %{} :Leaf (:at 1507399915531) (:by |root) (:text |*reel)
                    |r $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |:changes)
                    |v $ %{} :Expr (:at 1499755354983) (:by nil)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |fn)
                        |j $ %{} :Expr (:at 1499755354983) (:by nil)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1612280609284) (:by |rJG4IHzWf) (:text |reel)
                            |j $ %{} :Leaf (:at 1612280610651) (:by |rJG4IHzWf) (:text |prev)
                        |r $ %{} :Expr (:at 1499755354983) (:by nil)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |render-app!)
                |yD $ %{} :Expr (:at 1507461684494) (:by |root)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1507461739167) (:by |root) (:text |listen-devtools!)
                    |j $ %{} :Leaf (:at 1624007376825) (:by |rJG4IHzWf) (:text ||k)
                    |r $ %{} :Leaf (:at 1507461693919) (:by |root) (:text |dispatch!)
                |yL $ %{} :Expr (:at 1518157357847) (:by |root)
                  :data $ {}
                    |j $ %{} :Leaf (:at 1646150136497) (:by |rJG4IHzWf) (:text |js/window.addEventListener)
                    |r $ %{} :Leaf (:at 1518157458163) (:by |root) (:text ||beforeunload)
                    |v $ %{} :Expr (:at 1612344221583) (:by |rJG4IHzWf)
                      :data $ {}
                        |D $ %{} :Leaf (:at 1612344222204) (:by |rJG4IHzWf) (:text |fn)
                        |L $ %{} :Expr (:at 1612344222530) (:by |rJG4IHzWf)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1612344223520) (:by |rJG4IHzWf) (:text |event)
                        |T $ %{} :Expr (:at 1612344224533) (:by |rJG4IHzWf)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1533919515671) (:by |rJG4IHzWf) (:text |persist-storage!)
                |yO $ %{} :Expr (:at 1646150039456) (:by |rJG4IHzWf)
                  :data $ {}
                    |D $ %{} :Leaf (:at 1646150045747) (:by |rJG4IHzWf) (:text |flipped)
                    |T $ %{} :Leaf (:at 1646150042154) (:by |rJG4IHzWf) (:text |js/setInterval)
                    |b $ %{} :Leaf (:at 1646150175987) (:by |rJG4IHzWf) (:text |60000)
                    |h $ %{} :Leaf (:at 1646150050057) (:by |rJG4IHzWf) (:text |persist-storage!)
                |yP $ %{} :Expr (:at 1518157492640) (:by |root)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1518157495438) (:by |root) (:text |let)
                    |j $ %{} :Expr (:at 1518157495644) (:by |root)
                      :data $ {}
                        |T $ %{} :Expr (:at 1518157495826) (:by |root)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1518157496930) (:by |root) (:text |raw)
                            |j $ %{} :Expr (:at 1518157497615) (:by |root)
                              :data $ {}
                                |j $ %{} :Leaf (:at 1646150065132) (:by |rJG4IHzWf) (:text |js/localStorage.getItem)
                                |r $ %{} :Expr (:at 1518157506313) (:by |root)
                                  :data $ {}
                                    |T $ %{} :Leaf (:at 1544956709260) (:by |rJG4IHzWf) (:text |:storage-key)
                                    |j $ %{} :Leaf (:at 1527788293499) (:by |root) (:text |config/site)
                    |r $ %{} :Expr (:at 1518157514334) (:by |root)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1533919640958) (:by |rJG4IHzWf) (:text |when)
                        |j $ %{} :Expr (:at 1518157515117) (:by |root)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1518157515786) (:by |root) (:text |some?)
                            |j $ %{} :Leaf (:at 1518157516878) (:by |root) (:text |raw)
                        |r $ %{} :Expr (:at 1518157521635) (:by |root)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1518157523818) (:by |root) (:text |dispatch!)
                            |j $ %{} :Expr (:at 1688397806134) (:by |rJG4IHzWf)
                              :data $ {}
                                |D $ %{} :Leaf (:at 1688397806833) (:by |rJG4IHzWf) (:text |::)
                                |T $ %{} :Leaf (:at 1518157669936) (:by |root) (:text |:hydrate-storage)
                                |b $ %{} :Expr (:at 1688397811073) (:by |rJG4IHzWf)
                                  :data $ {}
                                    |T $ %{} :Leaf (:at 1688397811073) (:by |rJG4IHzWf) (:text |parse-cirru-edn)
                                    |b $ %{} :Leaf (:at 1688397811073) (:by |rJG4IHzWf) (:text |raw)
                |yT $ %{} :Expr (:at 1499755354983) (:by nil)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |println)
                    |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text "||App started.")
          |mount-target $ %{} :CodeEntry (:doc |)
            :code $ %{} :Expr (:at 1499755354983) (:by nil)
              :data $ {}
                |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |def)
                |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |mount-target)
                |r $ %{} :Expr (:at 1499755354983) (:by nil)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1624469553191) (:by |rJG4IHzWf) (:text |.!querySelector)
                    |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |js/document)
                    |r $ %{} :Leaf (:at 1499755354983) (:by |root) (:text ||.app)
          |persist-storage! $ %{} :CodeEntry (:doc |)
            :code $ %{} :Expr (:at 1533919515671) (:by |rJG4IHzWf)
              :data $ {}
                |T $ %{} :Leaf (:at 1533919517365) (:by |rJG4IHzWf) (:text |defn)
                |j $ %{} :Leaf (:at 1533919515671) (:by |rJG4IHzWf) (:text |persist-storage!)
                |n $ %{} :Expr (:at 1646150052705) (:by |rJG4IHzWf)
                  :data $ {}
                |r $ %{} :Expr (:at 1646150152124) (:by |rJG4IHzWf)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1646150154932) (:by |rJG4IHzWf) (:text |js/console.log)
                    |b $ %{} :Leaf (:at 1646150157857) (:by |rJG4IHzWf) (:text "|\"persist")
                |v $ %{} :Expr (:at 1533919515671) (:by |rJG4IHzWf)
                  :data $ {}
                    |j $ %{} :Leaf (:at 1646150150852) (:by |rJG4IHzWf) (:text |js/localStorage.setItem)
                    |r $ %{} :Expr (:at 1533919515671) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1544956703087) (:by |rJG4IHzWf) (:text |:storage-key)
                        |j $ %{} :Leaf (:at 1533919515671) (:by |rJG4IHzWf) (:text |config/site)
                    |v $ %{} :Expr (:at 1533919515671) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1624469402829) (:by |rJG4IHzWf) (:text |format-cirru-edn)
                        |j $ %{} :Expr (:at 1533919515671) (:by |rJG4IHzWf)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1533919515671) (:by |rJG4IHzWf) (:text |:store)
                            |j $ %{} :Leaf (:at 1533919515671) (:by |rJG4IHzWf) (:text |@*reel)
          |reload! $ %{} :CodeEntry (:doc |)
            :code $ %{} :Expr (:at 1626201152815) (:by |rJG4IHzWf)
              :data $ {}
                |D $ %{} :Leaf (:at 1626201153853) (:by |rJG4IHzWf) (:text |defn)
                |L $ %{} :Leaf (:at 1626201157449) (:by |rJG4IHzWf) (:text |reload!)
                |P $ %{} :Expr (:at 1626201163076) (:by |rJG4IHzWf)
                  :data $ {}
                |T $ %{} :Expr (:at 1626201191606) (:by |rJG4IHzWf)
                  :data $ {}
                    |D $ %{} :Leaf (:at 1626201192115) (:by |rJG4IHzWf) (:text |if)
                    |L $ %{} :Expr (:at 1626201192626) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1626201534497) (:by |rJG4IHzWf) (:text |nil?)
                        |j $ %{} :Leaf (:at 1626201194806) (:by |rJG4IHzWf) (:text |build-errors)
                    |T $ %{} :Expr (:at 1626201164538) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1626201161775) (:by |rJG4IHzWf) (:text |do)
                        |j $ %{} :Expr (:at 1614750747553) (:by |rJG4IHzWf)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1614750747553) (:by |rJG4IHzWf) (:text |remove-watch)
                            |j $ %{} :Leaf (:at 1614750747553) (:by |rJG4IHzWf) (:text |*reel)
                            |r $ %{} :Leaf (:at 1614750747553) (:by |rJG4IHzWf) (:text |:changes)
                        |r $ %{} :Expr (:at 1507461699387) (:by |root)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1507461702453) (:by |root) (:text |clear-cache!)
                        |v $ %{} :Expr (:at 1612280627439) (:by |rJG4IHzWf)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1612280627439) (:by |rJG4IHzWf) (:text |add-watch)
                            |j $ %{} :Leaf (:at 1612280627439) (:by |rJG4IHzWf) (:text |*reel)
                            |r $ %{} :Leaf (:at 1612280627439) (:by |rJG4IHzWf) (:text |:changes)
                            |v $ %{} :Expr (:at 1612280627439) (:by |rJG4IHzWf)
                              :data $ {}
                                |T $ %{} :Leaf (:at 1612280627439) (:by |rJG4IHzWf) (:text |fn)
                                |j $ %{} :Expr (:at 1612280627439) (:by |rJG4IHzWf)
                                  :data $ {}
                                    |T $ %{} :Leaf (:at 1612280627439) (:by |rJG4IHzWf) (:text |reel)
                                    |j $ %{} :Leaf (:at 1612280627439) (:by |rJG4IHzWf) (:text |prev)
                                |r $ %{} :Expr (:at 1612280627439) (:by |rJG4IHzWf)
                                  :data $ {}
                                    |T $ %{} :Leaf (:at 1612280627439) (:by |rJG4IHzWf) (:text |render-app!)
                        |x $ %{} :Expr (:at 1507461704162) (:by |root)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1507461706990) (:by |root) (:text |reset!)
                            |j $ %{} :Leaf (:at 1507461708965) (:by |root) (:text |*reel)
                            |r $ %{} :Expr (:at 1507461710020) (:by |root)
                              :data $ {}
                                |T $ %{} :Leaf (:at 1507461730190) (:by |root) (:text |refresh-reel)
                                |j $ %{} :Leaf (:at 1507461719097) (:by |root) (:text |@*reel)
                                |r $ %{} :Leaf (:at 1507461721870) (:by |root) (:text |schema/store)
                                |v $ %{} :Leaf (:at 1507461722724) (:by |root) (:text |updater)
                        |y $ %{} :Expr (:at 1626777542168) (:by |rJG4IHzWf)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1626777542168) (:by |rJG4IHzWf) (:text |hud!)
                            |j $ %{} :Leaf (:at 1626777542168) (:by |rJG4IHzWf) (:text "|\"ok~")
                            |r $ %{} :Leaf (:at 1679237703306) (:by |rJG4IHzWf) (:text "|\"Ok")
                    |j $ %{} :Expr (:at 1626201203433) (:by |rJG4IHzWf)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1626290831868) (:by |rJG4IHzWf) (:text |hud!)
                        |b $ %{} :Leaf (:at 1626290930377) (:by |rJG4IHzWf) (:text "|\"error")
                        |j $ %{} :Leaf (:at 1626201209903) (:by |rJG4IHzWf) (:text |build-errors)
          |render-app! $ %{} :CodeEntry (:doc |)
            :code $ %{} :Expr (:at 1499755354983) (:by nil)
              :data $ {}
                |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |defn)
                |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |render-app!)
                |r $ %{} :Expr (:at 1499755354983) (:by nil)
                  :data $ {}
                |v $ %{} :Expr (:at 1499755354983) (:by nil)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1624469436438) (:by |rJG4IHzWf) (:text |render!)
                    |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |mount-target)
                    |r $ %{} :Expr (:at 1499755354983) (:by nil)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |comp-container)
                        |j $ %{} :Leaf (:at 1507400119272) (:by |root) (:text |@*reel)
                    |v $ %{} :Leaf (:at 1623915174985) (:by |rJG4IHzWf) (:text |dispatch!)
        :ns $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1499755354983) (:by nil)
            :data $ {}
              |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |ns)
              |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |app.main)
              |r $ %{} :Expr (:at 1499755354983) (:by nil)
                :data $ {}
                  |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |:require)
                  |j $ %{} :Expr (:at 1499755354983) (:by nil)
                    :data $ {}
                      |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |respo.core)
                      |r $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |:refer)
                      |v $ %{} :Expr (:at 1499755354983) (:by nil)
                        :data $ {}
                          |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |render!)
                          |r $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |clear-cache!)
                  |v $ %{} :Expr (:at 1499755354983) (:by nil)
                    :data $ {}
                      |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |app.comp.container)
                      |r $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |:refer)
                      |v $ %{} :Expr (:at 1499755354983) (:by nil)
                        :data $ {}
                          |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |comp-container)
                  |y $ %{} :Expr (:at 1499755354983) (:by nil)
                    :data $ {}
                      |j $ %{} :Leaf (:at 1508556737455) (:by |root) (:text |app.updater)
                      |r $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |:refer)
                      |v $ %{} :Expr (:at 1499755354983) (:by nil)
                        :data $ {}
                          |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |updater)
                  |yT $ %{} :Expr (:at 1499755354983) (:by nil)
                    :data $ {}
                      |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |app.schema)
                      |r $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |:as)
                      |v $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |schema)
                  |yj $ %{} :Expr (:at 1507399674125) (:by |root)
                    :data $ {}
                      |j $ %{} :Leaf (:at 1507399678694) (:by |root) (:text |reel.util)
                      |r $ %{} :Leaf (:at 1507399680625) (:by |root) (:text |:refer)
                      |v $ %{} :Expr (:at 1507399680857) (:by |root)
                        :data $ {}
                          |j $ %{} :Leaf (:at 1518156292092) (:by |root) (:text |listen-devtools!)
                  |yr $ %{} :Expr (:at 1507399683930) (:by |root)
                    :data $ {}
                      |j $ %{} :Leaf (:at 1507399687162) (:by |root) (:text |reel.core)
                      |r $ %{} :Leaf (:at 1507399688098) (:by |root) (:text |:refer)
                      |v $ %{} :Expr (:at 1507399688322) (:by |root)
                        :data $ {}
                          |j $ %{} :Leaf (:at 1507399691010) (:by |root) (:text |reel-updater)
                          |q $ %{} :Leaf (:at 1518156288482) (:by |root) (:text |refresh-reel)
                  |yv $ %{} :Expr (:at 1507399715229) (:by |root)
                    :data $ {}
                      |j $ %{} :Leaf (:at 1507399717674) (:by |root) (:text |reel.schema)
                      |r $ %{} :Leaf (:at 1507399755750) (:by |root) (:text |:as)
                      |v $ %{} :Leaf (:at 1507399757678) (:by |root) (:text |reel-schema)
                  |yy $ %{} :Expr (:at 1527788302920) (:by |root)
                    :data $ {}
                      |j $ %{} :Leaf (:at 1527788304925) (:by |root) (:text |app.config)
                      |r $ %{} :Leaf (:at 1527788306048) (:by |root) (:text |:as)
                      |v $ %{} :Leaf (:at 1527788306884) (:by |root) (:text |config)
                  |yyT $ %{} :Expr (:at 1626201173819) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1626201180939) (:by |rJG4IHzWf) (:text "|\"./calcit.build-errors")
                      |j $ %{} :Leaf (:at 1626201183958) (:by |rJG4IHzWf) (:text |:default)
                      |r $ %{} :Leaf (:at 1626201187310) (:by |rJG4IHzWf) (:text |build-errors)
                  |yyj $ %{} :Expr (:at 1626290808117) (:by |rJG4IHzWf)
                    :data $ {}
                      |T $ %{} :Leaf (:at 1626290810913) (:by |rJG4IHzWf) (:text "|\"bottom-tip")
                      |j $ %{} :Leaf (:at 1626290816153) (:by |rJG4IHzWf) (:text |:default)
                      |r $ %{} :Leaf (:at 1626290825711) (:by |rJG4IHzWf) (:text |hud!)
      |app.schema $ {}
        :defs $ {}
          |store $ %{} :CodeEntry (:doc |)
            :code $ %{} :Expr (:at 1499755354983) (:by nil)
              :data $ {}
                |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |def)
                |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |store)
                |r $ %{} :Expr (:at 1499755354983) (:by nil)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |{})
                    |j $ %{} :Expr (:at 1499755354983) (:by nil)
                      :data $ {}
                        |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |:states)
                        |j $ %{} :Expr (:at 1499755354983) (:by nil)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |{})
                            |j $ %{} :Expr (:at 1584781004285) (:by |rJG4IHzWf)
                              :data $ {}
                                |T $ %{} :Leaf (:at 1584781007054) (:by |rJG4IHzWf) (:text |:cursor)
                                |j $ %{} :Expr (:at 1584781007287) (:by |rJG4IHzWf)
                                  :data $ {}
                                    |T $ %{} :Leaf (:at 1584781007486) (:by |rJG4IHzWf) (:text |[])
        :ns $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1499755354983) (:by nil)
            :data $ {}
              |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |ns)
              |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |app.schema)
      |app.updater $ {}
        :defs $ {}
          |updater $ %{} :CodeEntry (:doc |)
            :code $ %{} :Expr (:at 1499755354983) (:by nil)
              :data $ {}
                |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |defn)
                |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |updater)
                |r $ %{} :Expr (:at 1499755354983) (:by nil)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |store)
                    |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |op)
                    |v $ %{} :Leaf (:at 1519489491135) (:by |root) (:text |op-id)
                    |x $ %{} :Leaf (:at 1519489492110) (:by |root) (:text |op-time)
                |v $ %{} :Expr (:at 1499755354983) (:by nil)
                  :data $ {}
                    |T $ %{} :Leaf (:at 1688397777636) (:by |rJG4IHzWf) (:text |tag-match)
                    |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |op)
                    |n $ %{} :Expr (:at 1507399852251) (:by |root)
                      :data $ {}
                        |T $ %{} :Expr (:at 1688397783265) (:by |rJG4IHzWf)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1507399855618) (:by |root) (:text |:states)
                            |b $ %{} :Leaf (:at 1688397785768) (:by |rJG4IHzWf) (:text |cursor)
                            |h $ %{} :Leaf (:at 1688397786090) (:by |rJG4IHzWf) (:text |s)
                        |j $ %{} :Expr (:at 1584874625235) (:by |rJG4IHzWf)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1584874626558) (:by |rJG4IHzWf) (:text |update-states)
                            |j $ %{} :Leaf (:at 1584874628374) (:by |rJG4IHzWf) (:text |store)
                            |r $ %{} :Leaf (:at 1688397788043) (:by |rJG4IHzWf) (:text |cursor)
                            |t $ %{} :Leaf (:at 1688397788324) (:by |rJG4IHzWf) (:text |s)
                    |t $ %{} :Expr (:at 1518157547521) (:by |root)
                      :data $ {}
                        |T $ %{} :Expr (:at 1688397789504) (:by |rJG4IHzWf)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1518157657108) (:by |root) (:text |:hydrate-storage)
                            |b $ %{} :Leaf (:at 1688397790936) (:by |rJG4IHzWf) (:text |data)
                        |j $ %{} :Leaf (:at 1584874637339) (:by |rJG4IHzWf) (:text |data)
                    |u $ %{} :Expr (:at 1688397780767) (:by |rJG4IHzWf)
                      :data $ {}
                        |D $ %{} :Leaf (:at 1688397781225) (:by |rJG4IHzWf) (:text |_)
                        |T $ %{} :Expr (:at 1688397780408) (:by |rJG4IHzWf)
                          :data $ {}
                            |T $ %{} :Leaf (:at 1688397780408) (:by |rJG4IHzWf) (:text |do)
                            |b $ %{} :Expr (:at 1688397780408) (:by |rJG4IHzWf)
                              :data $ {}
                                |T $ %{} :Leaf (:at 1688397780408) (:by |rJG4IHzWf) (:text |println)
                                |b $ %{} :Leaf (:at 1688397780408) (:by |rJG4IHzWf) (:text "|\"unknown op:")
                                |h $ %{} :Leaf (:at 1688397780408) (:by |rJG4IHzWf) (:text |op)
                            |h $ %{} :Leaf (:at 1688397780408) (:by |rJG4IHzWf) (:text |store)
        :ns $ %{} :CodeEntry (:doc |)
          :code $ %{} :Expr (:at 1499755354983) (:by nil)
            :data $ {}
              |T $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |ns)
              |j $ %{} :Leaf (:at 1499755354983) (:by |root) (:text |app.updater)
              |r $ %{} :Expr (:at 1584874614885) (:by |rJG4IHzWf)
                :data $ {}
                  |T $ %{} :Leaf (:at 1584874616480) (:by |rJG4IHzWf) (:text |:require)
                  |j $ %{} :Expr (:at 1584874616720) (:by |rJG4IHzWf)
                    :data $ {}
                      |j $ %{} :Leaf (:at 1584874620034) (:by |rJG4IHzWf) (:text |respo.cursor)
                      |r $ %{} :Leaf (:at 1584874621356) (:by |rJG4IHzWf) (:text |:refer)
                      |v $ %{} :Expr (:at 1584874621524) (:by |rJG4IHzWf)
                        :data $ {}
                          |j $ %{} :Leaf (:at 1584874623096) (:by |rJG4IHzWf) (:text |update-states)
  :users $ {}
    |rJG4IHzWf $ {} (:avatar nil) (:id |rJG4IHzWf) (:name |chen) (:nickname |chen) (:password |d41d8cd98f00b204e9800998ecf8427e) (:theme :star-trail)
    |root $ {} (:avatar nil) (:id |root) (:name |root) (:nickname |root) (:password |d41d8cd98f00b204e9800998ecf8427e) (:theme :star-trail)
