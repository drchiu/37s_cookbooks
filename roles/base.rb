name "base"
description "Base role that applies to all servers"
recipes "ruby-shadow", "hosts", "dns::client", "chef::client", "nagios::client", "rubygems::client", "timezone",
        "git", "postfix", "ssh::server", "users", "sudo", "sysadmin", "mysql::client", "chef::client", "collectd"

override_attributes :active_groups => {:admin => {:enabled => true}},
                  :active_sudo_groups => {:admin => {:enabled => true}},
                  :sysadmin_email => "sysadmins@37signals.com",
                  :sysadmin_sms_email => "sysadmins@37signals.com",
                  :campfire_subdomain => "37s",
                  :campfire_email => "monitoring@37signals.com",
                  :campfire_password => "0hs0tast33",
                  :monitoring_campfire_room => "System Administration",
                  :clickatell_username => "37signals",
                  :clickatell_api_id => "3131956",
                  :clickatell_password => "EIJVhiv4",
                  :default_domain => "37signals.com",
                  :gems_path => `gem env gemdir`.chomp!,
                  :ruby_path => `which ruby`.chomp!,
                  :jabber_domain => "37signals.com",
                  :jabber_admin_password => "x9CR0!7#z3ux7P",
                  :dyndns_login => "883mhi-ec2dyn",
                  :dyndns_password => "5SkR2hJiNsQP",
                  :apache => {:listen_ports => [80,443]},
                  :groups => {:app => {:gid => 1003},
                              :site => {:gid => 3001},
                              :support => {:gid => 3002},
                              :storage => {:gid => 3003},
                              :admin   => {:gid => 4000}},

                  :users => {:app => {:password => "$1$hk40k332$wpSYJYlbbVo3AK/7thxO3.", :comment => "App User", :uid => 1003, :group => :app, :ssh_key_groups => [:app,:site,:admin], :extra_ssh_keys => [:nagios, :solr]},
                             :site => {:password => "$1$4k01kee3$tQkwp46/ngyG.iH4kIaTJ0", :comment => "Site User", :uid => 4000, :group => :site, :ssh_key_groups => [:app,:site,:admin]},
                             :joshua => {:password => "$1$2B2ZNpWj$poiTyPOZxozN75xDkt4DT.", :comment => "Joshua Sierles", :uid => 3010, :group => :admin, :yubikey_id => 'dtnkddnltnhk', :http_digest => 'Q0ow3S0HISHc.'},
                             :mark => {:password => "$1$/Tksj8KW$Vqswv0AALCtHLMog3z6kk/", :comment => "Mark Imbriaco",  :uid => 3011, :group => :admin,  :yubikey_id => 'fffnfcuikinj', :http_digest => 'Dyil3x.G1g872'},
                             :david => {:password => "$1$1EcOMWnu$E/TtE2ODkJKKiOgOq14Sq1", :comment => "DHH", :uid => 3012, :group => :app},
                             :jamis => {:password => "$1$n7kJKJ7s$.Jtb56SLe8lhWxIekaqpN0", :comment => "Jamis Buck", :uid => 3013, :group => :app},
                             :sam => {:password => "$1$6cIAM7hX$4w6vLIp2Wp8at6VksADJg0", :comment => "Sam Stephenson", :uid => 3014, :group => :app},
                             :jeremy => {:password => "$1$pphqNx4n$LS783nrUBTe4xH8ixpONw.", :comment => "Jeremy Kemper", :uid => 3015, :group => :app},
                             :jeff => {:password => "$1$D5iSTU.m$9kri2Qq0UfUeLb9cjnn4E0", :comment => "Jeff Hardy", :uid => 3016, :group => :app},
                             :josh => {:password => "$1$4NsbdsC2$qnPvm0nE0J2kNmHgqGfTO1", :comment => "Josh Peek", :uid => 3017, :group => :app},
                             :jamie => {:password => "$1$/cNS7YPq$Ko/qjme0ofsKIf2nZruZv1", :comment => "Jamie Dihiansan", :uid => 3018, :group => :site},
                             :ryan => {:password => "$1$F4RLmWHq$SmMk24KYh/M0UPCqEfJ3s1", :comment => "Ryan Singer", :uid => 3019, :group => :site},
                             :jason => {:password => "$1$uZBGnixP$IObtQbltwN/OMqYOvETgo.", :comment => "Jason Fried", :uid => 3020, :group => :site},
                             :matt => {:password => "$1$uZBGnixP$IObtQbltwN/OMqYOvETgo.", :comment => "Matt Linderman", :uid => 3021, :group => :site},
                             :craig => {:password => "$1$9UPxs06v$YP5cJBW0hDxiZcu1GGryi/", :comment => "Craig Davey", :uid => 3024, :group => :app},
                             :sarah => {:password => "$1$U0cG83um$O2rd3ewKpBseLoy6OLLfg0", :comment => "Sarah Hatter", :uid => 3022, :group => :support},
                             :michael => {:password => "$1$vT.aW0Bk$dZ29mgu32LVuieh6w5z.4.", :comment => "Michael Berger", :uid => 3023, :group => :support},
                             :storage => {:password => "$1$hk40k332$wpSYJYlbbVo3AK/7thxO3.", :comment => "Bulk Storage", :uid => 3025, :group => :bulk, :ssh_key_groups => [:storage]},},
     
                  :ssh_keys =>
                     {:david => "ssh-dss AAAAB3NzaC1kc3MAAAEBAMz5mPUa2WubrwTgE1VXPdmPSkT0qoU71vh4elJRaj0VWypb2c3IPyyGSdWjsCBSHUSUBUR4VL5fSJfu1QKrHVpt0BIU7Nl+dvCwATAeL9j3k0cpzYrjPhXLZQ4UStfh+Tpo20QitzXQ2ceoFaiVNXf5upUP+Yz+jTqhLkcjWVlIdas/eiVldXVtLEUqUo6RUTcaVLbb8ksp6lhZp1iVV8k07OMButiCB3X3k5kQxCnCMzzWI5IDP6VSacu5gUwIjnS2hB0S3lSBSgJL+YBOBWqjBW4HCqPHMkphEyxUs0GtVia1qdhIs62m8tMMD6hWiqr7+ATJi0xf0iI31TjUxSUAAAAVAPS7EZNGzL+bknalDVdd5JpTFlqfAAABAD1fD+2u1fAh/pMeUnj7fwNGVEH0NwjePLyrZiCV1qvcqfR2FOH6pJS5ntQPgo+bi33MnkXqp/dnkEdpWar/CRo9FgIcyQ4NUSkXYwlhY6HM+PxTQvM5WhRMpJqfcfQKXdhV8hlf293p5roWYmbale4vq+Kz+bpVnIxO+UQqvb1nbnbzB9/ztWWjKwTKUPklvja52g3tWYH1tywzGVHukLoiedZGwqw3kHT8FQgORAr2AbE8Bn++cT6PUr78PXUl537OLVTwtNPK/taB8mm4Fwbriz9fiEdvgtfsji+1vqkJubeUmQi8TPq5iwsthE3TPyY6Ip1ZJlPO8LTXENGyvD8AAAEAUYs2ZCRntt59ryfOsXiu4J/vYpzbSbBqXmX5wBzbb23qmZGd8LBLzUY6NwgR6NbD41e0qx31IGK5KE8fFX/z+oaZfQBw/Vt72QuyypdMcqYXVN4/AOv4u8+pqb7q+m1qULgGoi+/DMKE61mxw0+iiFz+drUr3ZF+9weuVE+xWlBWIze+GOBxMDVrKjvK4wuGFl67gD8F5/wcA8pRDltYVYgwkuf22L+o1ZvYRt+4861kAUfqeP2HM24+swXgPOK1Mi/3AZupqTFTSB1NruDlvd2xBKAMqSMv9sIc0y89cATd9Divusb85zRJVsIGQz19l7UUgA0Ogvwdm0+t4zr2Kw== david@Envy5.local",
                     :joshua => "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAw942jLhdXBPHljWtE42B1XeFuWSJU/+w4pVTwdID6KEf8KF1cx/Jc0EJnA2ipMgJtUCJolWyt0PdGcqf8oE7UbrkzCW78g+zLa8muxUdHF6JK0b/nQW0plj8rg3rTxTz4lIi46AgW1iC9XXKlcX1IRC3w0Y9Lu+RMyGxdifFNHSj3g+Vd2QfHJBQkQz4Nx1ngT+y6y/966K/AIJHej67MmuCHRTxMKxX5vxmbvHP8WgSvylgx+mkTuYhUzGaQtvopM6zzXLfIsicnxVIu1hWjXlle55t0EamGysjGrJFbYiunbWDlwRfZOBe/ZKec5rBPLxwBC1xQ2F4sOJFUE+iUQ== jsierles@MacAir.local",
                     :mark => "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA0TNuoIMw5w7LgDm2RpGRIgPVxk7Ks1Y6Mque5KisLM02jbq4WdT1xsjtN74ibnAzG51vkjSgqRmXmmqiiDvafD06fTf6QrM3LZ7L1sOMu/ovKcKtISIwcU0kOzVvq9WXWinhm99iL11CUvA/gGIavHNmAfleq5NZr3uSV2r+PyZerOCcJH3D3c8iT22+8MZO9KNELlaXq+pYqbmfyGzEJuLD3VM94+VW2oFnBuRFMdmd6N6ts2+JOYLUUqH8T0S3D1tchSGSMaRV0gO8+4IH8GcUPI2DpQYsz8eW/90+cOfRaDqqIL1uJbS+ORESlMPqoamtXCdYrTBqsPgKyLhM5Q== mark@strongbad",
                     :jason => "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAvsuq0mr3S3xWT9qJOfmdxK4U+6KTFAD5e12LOQ9aUUFQTNTDinztR4r7aoHBnsoNsAE98WeX9XsZrIwWpfbyO/VQS+J/q4fygtiBOpITwZbcQVGDly2eFP+Z4C/F5dst1mdQzpZoQ+8ucFwt6hGbU9QL2EKasQa3swnSmGHfV8oLokvfTbndsB8hng0lo/TiwN20ihGswicbEXSi1TBKPirX4glw2B/qxNLM8T3hRTzYqjbfMyhIBZRjA8IBjJrVJXNIuIUGG67TN2rps1/oIseIzCIPlROiDBWyf3JAmOYTFIEfXSticQjUJ8UOO/RhMqJC0tKDT0ONsWLmGCrxmw== jbf@jfMBP-unibody.local",
                     :ryan => "ssh-dss AAAAB3NzaC1kc3MAAAEBAOChqYhd5DHfg8jZf4ASMWuuz1VA6APTev9rqXYPbCs99P4FolscCnTZuKmhUaro4nV1fXXDa1l/BQPvqAnDXBfX90WkpkPLf8AvG/O92GKofsBQhaaKx28xd+8wnSaooYS4ZwLL20vVsWHItHqt7Ahs7cN1lUzXXxrosEtdwsIAESiRCCjZTA38sXnwOtu2Hr9QmJiTqra7jbqaQe7mAA/rZpSxyv0nlyJNObpfBklKEkELoOfUt8EnFDZCDmLGIkvChJFTDzUJ6xUh0aI52MyJ4xkQbW36CAN9ISnQQ08HM9AmyibwPlKWZGrjpz8hjhVpyYQTMxDvtA9tAJn0de8AAAAVALhMW47B+hQ0aYHP6O/xNI2D6nIVAAABAAxXsaW+nvdINH03SGf3FFDN0hSf5YvW8Z+pqBZGZODUZzfd0+nh9wegM1Le8hzPL2IMTqtqc4VMw8yE5q+j+GAmUPqjMrPQZJYtEJp3dsG60NOEDrzaVqyOgh/1mfQQqxcM+2u8NuyIBXwhDPXj9c2u5CdAsDC2ZGsbVtwHAX1CHGRABz0Gy7PlDto+GgdK2hxZleH5w4qCJTyweohM611IohNuQy2PBLA8aoPcPK1sbHAxl12Pe8WhhjSUtQf1FMHkBl08hyekEPooynC7/P/psWDYC3DHfDSGJo9Ff+Km5okT5/cpeq45An75FkoQte3qyqR3i+QRj1nCCIvE0UUAAAEAE/ydjpK/vnIU/YrukiGiNbaKBneeMqug0RZeYQuCXAfDiZ01dx1hTPxrx+Z+I4ClgVE34BQqvMvFXScYsL4qiNaax0BeYvo0TV+KBnp3biiVc+2L57H8UCXKBIx4jEYC9GDUiEbpViWdzevcvfZK5+kGvop7D31JWBe58fJudQA/zX0PqKDxAOFsUnacbT1DVAzx3h6tbnnQnEVpip4voc1Fz6vmo5UQYvfXiCI9yC6MXTKj6MTsJQAm/fRKiL8w794Aep6mIhSrr7dpMD6dMnohLSVCk0RzvySU1Vmyuu3E5m12rESxhIhbVWrJNWvlTP/MqWfzTzWTbTzKwmf4cg== ryan@dorje.local",
                     :jamis => "ssh-dss AAAAB3NzaC1kc3MAAACBAMjAG7kk7nTsqh0KfLCRnHdExbwZ3aBmUY1BJQZ9ROrnCZw7XJ73Ko46S3tr/v0x0vClQU+lbxzkSgACbSEKXaITSbhIAJqvhl68ny7DMoIeT3zYbFrgytqxRagUev9T5BoOZ0oOqLhe5dflrlI7pVvBZOkW473+T0528lmtYjL7AAAAFQCrv8DIhlCy5OQwrZ4JywI3yfx0NQAAAIAiW38I0hCQodRrmTGKdvf3CiWizESg2K4EpPusB1B5aFATpMafrn2g3suWZifDItHhnSu9yFjKZGgbtCQc3BfNOKn/GIg+bbX+LYGqiwKGVCJbbF+GZG1egEfRyab2cAbBgGI75U1xTlRWP+DXqf9l8N9rvonr1BOas5yZJ5N75QAAAIBR1ffx/7oC6O+ntljPXV9dbK+mzmYy3nFlzJX19aT0wxq4Y1AerGweJ3A/WmM3eY2w0w5wi9bpX4gB/6VGujj9HPuPgnLNpjLBFqT+1zdpjpU8bN8YGzfgY3v5xicwJa2fwjbjcJzVwYUY58BTqWce4v/uvalvQgM5/gDxv/KZAA== jgb3@serling",
                     :sam => "ssh-dss AAAAB3NzaC1kc3MAAAEBAJsjC6w11lxpzJPAzYILgFDDE03Re4gnHFDG0HwwUzsclrniQqsUoRo+IrUvh/RjDBUoEtavY6fuOyTBdC0sN0qMLUITYdBUb2bCQ9sKuLcidO3Qfdq5jKYbD2PevtBGouKTGweNL7NDhx8iVfynVh7P479MK7KYmXbazyR7Y4XufN35XyOsul6b3X6KWq5yCjq40nj1T6Mm+pIXndT+OaRCof0NgMyeN1X8w6gwXJ3NdPnoiam6B8C9V52/dWkkp9NcH7fLAGOaJnnKBZWkVvQJK4A97ba1HWmgG59A3hizLjSJzOT6t2C9833KHilR2kGvgO21fu0drS+ScMXyj+8AAAAVAL9E+Cp9q+Q+aMR5RqpdpioOFlJ5AAABAEqZ1JHAZzK7xXzdEMQybI4/mCr4tXP4PpW4UM/MHnk7AjASKcUpRtOETViHqGRAVvQehwHSrZYHp4R3RLwZGpBp3cRNyGrMfsRfurhys6lnfL0a32YEr/VHrqps/y94Ekkz40UTTbG7oNIFgI6r0qYREK6NUYKgZdH5ZCIcXTxhLIlWH+2cHiYMI0JvNm8hPuaSwv72AXpfofR59VLNW7or4g4N9KED66lKhiOn4zVCC7LrDOak9fsde4G1EOS7TllP21m6n6W+CLLk+fmd/jCvULN/RVQ/b6mg956lO9/YcIjtqYARTo62UG7yrZTx4ra1HvSJd1k1rvbP00H9xlIAAAEBAIXSSkINSzP3ekq41zNKxjF6os3sMWY+ibzjNK3XcC6dOT9WAYb9o8D8+uaR7rz5yxktqfknNxDjoMAkuhWTsKFnzotT3sDTI+HTxLMDedifnFI3njr9UV0CXdYTDHxXlU6Wtr9o/lgrLgrA/u/C/MWbl/Prm3rb5sm+gkXq13Lxa5+A0dxg11/XKFCtsAxzEaHcPibAkgGpVPCS11SrrtwVAPX/DuDf0SwqNdGAPapd5uR7f0tE2KIYNiupAQULfE5NciYj0rAlHk8+Kst8ux6ywoLOqoy599XbTMapGzHr2LeFjiePKiqq1yZbQV5G7+Ut+ybMXuaPpHwDCe56O2Q= sam@kid.w.sam.home.conio.net",
                     :jamie => "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAmvyjfIvphyTB5hnjnLq7CRiOWN0XOLwsLkBDxP3G0hrmudUIwZifQDza9+HtRy4mLJt2p1nOSVVs7oDtG801wc/9ni8EzzGxnGOPdoRfWGS46qy1R4JRMr1b5ebL0lLgQv7FpSlDvfwG9JKVRGibZeC5fu08R+5KRuEQHK2rg9nL/JAIsXl8MCvDLKF/zosPI56Cr++ub9T6OhiNdtAd/xkph44KEYKBk98CBTyEb5Nx8hBXgk1aNR1fdxYUOENF3L/6lycEhdaU2ztqy9l9rEbNFtt/VY0qA4yRWZNloWxXd90ydDToqOyX4eTJd6rHxYeGooATySL5YoSd4Kwaxw== jamie@AsianMackBook-Pro.local",
                     :josh => "ssh-dss AAAAB3NzaC1kc3MAAACBAL7Em127r7XKDMupp4knBm2evN49DDL6Rcq4PTsfmojkcmGVPnjqzcIfm79J1U1GSkFxOQ9Eha7XIvDbMvUuqVhfCcAi8uVpyZQ/fFFcF3OdNgBQ/FrzJY5db63ta4UGpph3EWZyLJUE14+mYJ1r3GTO/jCbGWxhZkkD07hBegY/AAAAFQDNuXmdNpRB/M7Ga2AySd8yAkRyhQAAAIBb7HBn+1/UNycTon++/eT5HeriCrVy6G9zqKm6M4HY71TTMD+qhOkGlhqX6C2mTcRFfdPh5f3/qpMRVIQgyBaVWwlST+HhQMm5SqAr6LpsiZo/q+iMUGV4PeTRBsuuNuWEUn6IPvca0BoHXoqZuzBx+P6l0kpcOgRMtKNKeiP0SAAAAIBBNOvt56nhUqskVsLn3NsCkXXKALjt4i/gFx32Jql/3FLCjG3Zz73TXBD90EMvz0gZTjLFX2B4a3sJ5qQz/jJWhgXhppC245x/8ygVZG1fhyZWJTDPe2kaFfPwSRabCWLJOJY4+kQ2AIzQg0BDlcFyQ/4MmhHJF+stKyYO/aJgQA== josh@Joshs-MacBook-Pro.local",
                     :matt => "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAtxvNj/M53kW5eWyyFc3ZiFAbfQ5TAMxJdYwMaaZNIwDLljOcX7etPSFAaWsG4bAQorFzlFSHLAS2fPWTQdtCdSRHAOGxjZh+h17ueQ3z6zgsHq8r/PgnA9M6qIubcJ1cRIm3VkSAVFaZnInSp3M3UNm0CWA1/Uj5T+ijDIZQIXpFH3DOgv4MZb54TkWDVZEMDLd2ImCw7RgALnEkTaX/w1h3VZBdvZWTtoppz8+ICwcRlW+oi2WxAkSdD3n0+itmJfjTVE5r+zl7/7pPMJCGIGwBhDJCt/DzwBTKYoe61rsMD3Wx91Qy2P8VOJtYZTgqGc3j3PbS5CzpkC/oZEMkzQ== mattruby@Leonard.local",
                     :jeff => "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAx0iwu7QIsXx6xbvWdQgqtG/ywwvTAgoWJX0e5fhkI0EV8TP6ot75gg6NxuQtRsQi3BcIvFI6K7kGvbY+7Bc4Hw2shGibqT7GPaaNMZWO4NyRPG8CNJd/B4xJNMO+Sp3x7zm6apaHbWwJiKbn5UddWxZNxX+tpV2lKYa0SjyUdGiK7Sgipl1MD5BMVCQ0876j17K3C88BldEpExItxC/8WPNwbLRSEiZf5ECsVITPCYkl4Gw/w1bEe0mx6VKO4HlJSkvRzevpzAvXSSfgrwK86nQ2AC5AXkr8Rdsks6oElxwzBeA/9346nA8W0cU8MmMYJBBfjMv6bUtNvWNGMwif0w== jeff@brunswick.local",
                     :jeremy => "ssh-dss AAAAB3NzaC1kc3MAAAEBAOPInDq5qLyFJ0+I3hxYdD9S6oYQvE5xPXeqYz9S9daNf+SnqzKPmUXUd/YeY3WF9ZpTDRTns1TSGCIsLqLohbTSD9tAPlVICEWRBDsEm6m4HlScyEDaGtM9JpZvawlOSfeXzio9l+/fNMpa1VxIVf6r7VdA2sXuFtessjWyRdUU7ta6ag1GTxiQsfUHfQdpiX4C95ITCWa9W1qqly0thQFEx+e7UZTn1DwlICalSSzgjDtnoIPzjSt7XPO62rgrXvW6gwT6FlS4ejUP39FH3nf7370x8EDQ44xJPrS43PXVnNa+74IoJiRWiEvJT3ZMZroGEln3BPLLkHJ4pXd+bn0AAAAVAJH5Z7jsb8QDYbriWmYlv6puUj0jAAABAQCg3QJb4nb+g5lGTTdLsyrljTIOgGBCwjNTX+j8PmTdnWpG0OaLuGWiWt+LpW5UOnGCVb4y0iyWqfh1GLt3pcZFXzXOF6SOikHOu6gcmgwaDtRFzRGMMFOrUhZtHYnYEICTmeY1XXnr/r9E6cgBcQ+Kt/DCbvOG+teny/yXTNIyARdtCUsIYl9Q7RiZOwgcNhmFcARogRUWqjOp4xgJOoeoPanlewKWQ7PcTICP/agr69ZAD9AqhMJP47SeHGpVNy5lgGztcVAMt9Sv0OqIeGJOQ7cIMkYdABN/D7ajsPFnPGAazMlB9J4O/FAtosErAubs5xgFDszMOKFGKH3bSSPeAAABAEPHSZsmQB9Ob5dyzlm4YlYF/iGPSyddH2EoRSwiqT9CoQqwVXzpEz+hPQGJbGx7sjgbxh4jwIH2bX18S33OHJ215ZhYmBDRa7Ztb5sIesHNjtVM+NnlIK25zXRhWmTpDbyygL64aZmHzE4XujnH0ARMtp1rjM6ikKtNTxoHD/SPktaeCsciJtsmFCxvqFqX9/0eT7S2cbq7Ot8hsg7yMShtJfuUdnKNU/me0ZqpNFaSewuA+W00qR6SKXkiPqWskdsIGUXNfY0kfAHG0xVTp1j4HzeilMpOGzy89chxCi7hT9HYOHmvEoRqCe96doHkCqDZUOJkkPPcsjXVG2JzK9E= jeremy@geech.local",
                     :app => "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAvcJRSTTh9LUTF2Z52hwsoL05NxXgjBwTl7ZkrCW/QPvQlw39zfzwz9AYI7YxuLaqhQK2i9JHt9Cop1yTsXFfzKEMHEF5g2mL9MUv2tDVy1+5EudjVx6NlNwY+4A1aS1K/467m0vrUnWzPhUhb9Z299oMNxd4JGCengjJY/MnwfoVndVL9g5XkcGLnC7pS/WmB+tqeeERc78vM3lPcraJmoU6p4RRG7SPrrX/ePPDCV4XPc815fmOArkTXTXXZyAFgeIkss2i5dq9O87CPBhx/nJB6bsGFd/j6leNa7ogJK22gLuN9rxEzZyurBj5QuguJzz4XdvrjHOfRkP+LcnFAQ== app@37s-app-01",
                     :craig => "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAr+10c5SdrsnaPPpKjZXPUQYqv5NQXc6yklrjkH2r2naTSKr06W5/viC2I3KpOrtdSJ2hupzYOoMTbkLBEEQSLaS/tbLqx2VvWuKvCzkFaJPK4C89MsGSFsKizIzUgf6+MiRHH1KHo74rMuJnlKa/LZqF6AtZRtUp/+ZX2xNFva1ZiXgsd1eRagp/owc7Rl+F1LS1GpBNxXhq5m1kxFZ2puRc+wPDgXv9h1eLMrQIx/TGLDi8BUgPplN6xHCBssjWc4SnHQXM+x7yYUzgsoDkQCkadRPWE6uS3M7DccLdWmGxH0nlqk3Ai3l8LkDCnpIdboJpNLtu7fjN4uNJJ6o48Q== me@craigdavey.ca",
                     :sarah => "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAwMnlTXspEIgOYmdntSgwCjOH0w3RqfoBZ8FRBxTiQIvHZJJonTxukwA6zPuaH9CfAq7swAQUzQrnmFsQ++7TFtC0NQdSldnyO6oRAIpAAUCauG9LaLwhr3LgOSySAJfETxZeesCnLHvSs/rWT0TIPXcqgADuvZcrYepLmTk+FDnHTS09j+070UMjwTuBjbEouFmJcWHI5Uu2Y8Bc5/MgGEwBh5epNBrU9vNAgad9P1Av1CKv1bYY7av92CYEOWainyP3clTC4fdJYFHgCDkbK9aMCtPcXKjsvLmHQt4ukO7EGzWAzNvHmXlORVJg7gTVEFZi0pJ0TqBfzHOulamcFw== sarah@dev.37signals.com",
                     :michael => "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA53phCOgf54FyqE2TwtTSzIRpnMHZ75Dt8xC6luL3nKXlCeb/daD3PMhN/Ymu2XUFe17d579cygUjeYp9G8hBIbLqJndXmuVbap8hYmaScGXYuCnHsvC1PAKwh+i66p8JdqK8hRgs29rsA737R+N3g7V08kcfPZ0PtIvl49TlfAw9z/OkCEch8RKTqUEKBn6RrshADEgg91IUN6cBBFgAzFHUa3W/ihvJHOfkrUS+rC80SpI9RjD0sLXoeRv3IE/uG1Nc6Fe4fmX6ezNcYFP3IQkP79KDgHuPO4Oalp7QMXcJZGLh5tjlhNYVAMZmzRhcDHY3rDZbbKMGM2totg3tFQ== michael@dev.37signals.com",
                     :nagios => "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA1XrZTbwTj6TfXpW5wLYtjcMl1fC5fWXpeHldglEP3poM8pwm+Yvwa8EQ6mcy1G/FCXLX5w9owz5R3p+8J1I32QehOsU4eFT/tU4CzTz1kA+0OJGjWIRecA5PKRxa6dc1N8xfEir+YFx9MabpjErZ8Us8hS48glpGavdKQzoKcy9VEk4JiddRYimTreiakc0elFeYJJbNYNC8x76lVPUr9Llw3d81rdJyi28Xv06oaNS+n0Oa/XnzSfKk+9anwbIymj9utf5tAJarAsOiC1CRBe4BRm9ALbsfBjbgn2JZoZmEjI2uG+1/hxoeXfPh1C048qNP+zdlClwlQM535vsKOQ== nagios@noc.37signals.com",
                     :solr => "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAmBDpYGrYau33dBcy5ms+KCCIWNGIli3dDOt7nfDwPrBXxgK7068zlGaroa9U8btE6pfYzjLXEldvqwP50+lfmGxTVfc/AC4fu+w0ojOWzA/pz3QS5gslMgJP1+iggryMVnlCc5nRHgJdg55aJ4XF/+nQ9kso4DSUCYC3RksrHu6WKn2tik2CEY0bcSEil2jzpgHnEwA0nFik3ahQr8UO2EdFACJ79vuQd9ZStUvokhak9xMT+49if9V4NSMxSzlsjm+PSlrStb0xzo39me2XJ9Irau1CJ2GGEA+GmZhUvg04Sn8LhysAuRDVx0tHeElPJB6wbpLNsU66PJjqLBdZBw== app@bc-solr-02",
                     :storage => "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEApuUKB9EclFR4vztKeXUNwReHGhfVLUINb3Y4iLK3JiC30BVe7blBEf3LUHX1PeeqCXRR4ioKrv2IKSrYPJLv4J3J/ePuMIxMX7pnSWrEi55YJNPquPv1yCBpCUveoP+7ABKxNUgTz+4CgFj7CsVTfUNK9IZ++rL9Vm1WPDczcJEhJrY31wtZXEZ16vMQnhh69lP7rty3W0TcX4dslADXvJBow+Idtd/xBQwKTBI9StK6w3R/vzkwmgBo6qF3eA+3RAxrsX7wLG2adNbhSPbWl7GpJgwNJCgrqa5dZngdJAySBnk/fHyUn4iG9ftysColbun+DFM0DCZrk7p+qjrqqQ== backup@bulk"
}
 
