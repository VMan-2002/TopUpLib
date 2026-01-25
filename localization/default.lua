return {
	topuplib = {
		collection_menus = {
			music = "Music",
			achievement = "Achievements",
			atlas = "Atlases",
			challenge = "Challenges",
			deckskin = "Deck Skins",
			drawstep = "Draw Steps",
			gradient = "Gradients",
			keybind = "Keybinds",
			language = "Languages",
			objecttype = "Object Types",
			rank = "Card Ranks",
			suit = "Card Suits",
			rarity = "Rarities",
			sound = "Sounds",
			stake = "Stakes",
			vars = "Game Variables"
		},
		debug_centers = "Debug Essentials",
		positive_sign = "+",
		asub = {
			--"#SUB": Inserts provided value here
			--Only one "#[...]SUB" is supported.
			chips = "{C:chips}#SUB{} Chips",
			mult = "{C:mult}#SUB{} Mult",
			xchips = "{X:chips,C:white}X#SUB{} Chips",
			xmult = "{X:mult,C:white}X#SUB{} Mult",
			echips = "{X:dark_edition,C:white}^#SUB{} Chips",
			emult = "{X:dark_edition,C:white}^#SUB{} Mult",
			eechips = "{X:dark_edition,C:white}^^#SUB{} Chips",
			eemult = "{X:dark_edition,C:white}^^#SUB{} Mult",
			eeechips = "{X:dark_edition,C:white}^^^#SUB{} Chips",
			eeemult = "{X:dark_edition,C:white}^^^#SUB{} Mult",
			
			basechips = "{C:chips}#SUB{} base Chips",
			basemult = "{C:mult}#SUB{} base Mult",
			basexchips = "{X:chips,C:white}X#SUB{} base Chips",
			basexmult = "{X:mult,C:white}X#SUB{} base Mult",
			baseechips = "{X:dark_edition,C:white}^#SUB{} base Chips",
			baseemult = "{X:dark_edition,C:white}^#SUB{} base Mult",
			baseeechips = "{X:dark_edition,C:white}^^#SUB{} base Chips",
			baseeemult = "{X:dark_edition,C:white}^^#SUB{} base Mult",
			baseeeechips = "{X:dark_edition,C:white}^^^#SUB{} base Chips",
			baseeeemult = "{X:dark_edition,C:white}^^^#SUB{} base Mult",
			
			barechips = "{C:chips}#SUB{}",
			baremult = "{C:mult}#SUB{}",
			barexchips = "{X:chips,C:white}X#SUB{}",
			barexmult = "{X:mult,C:white}X#SUB{}",
			bareexpo = "{X:dark_edition,C:white}^#SUB{}",
			
			money = "{C:money}$#SUB{}",
			xmoney = "{X:money,C:white}$X#SUB{}",
			emoney = "{X:money,C:white}$^#SUB{}",
			eemoney = "{X:money,C:white}$^^#SUB{}",
			eeemoney = "{X:money,C:white}$^^^#SUB{}",
			
			tarot = "{C:tarot}#SUB{}",
			planet = "{C:planet}#SUB{}",
			spectral = "{C:spectral}#SUB{}",
			code = "{C:cry_code}#SUB{}",
			
			chance = "{C:green}#SUB{}",
			
			musthaveroom = "{C:inactive}(Must have room){}",
			handsize = "{C:attention}#SUB{} hand size",
			
			common = "{C:common,E:1}#SUB{}",
			uncommon = "{C:uncommon,E:1}#SUB{}",
			rare = "{C:rare,E:1}#SUB{}",
			legendary = "{C:legendary,E:1}#SUB{}",
			epic = "{C:cry_epic,E:1}#SUB{}",
			exotic = "{C:cry_exotic,E:1}#SUB{}",
			
			currently = "{C:inactive}(Currently #SUB{C:inactive}){}",
			currentattention = "{C:inactive}(Currently {C:attention}#SUB{C:inactive}){}",
			currentchips = "{C:inactive}(Currently {C:chips}#SUB{C:inactive} Chips){}",
			currentmult = "{C:inactive}(Currently {C:mult}#SUB{C:inactive} Mult){}",
			currentxchips = "{C:inactive}(Currently {X:chips,C:white}X#SUB{C:inactive} Chips){}",
			currentxmult = "{C:inactive}(Currently {X:mult,C:white}X#SUB{C:inactive} Mult){}",
			currentechips = "{C:inactive}(Currently {X:dark_edition,C:white}^#SUB{C:inactive} Chips){}",
			currentemult = "{C:inactive}(Currently {X:dark_edition,C:white}^#SUB{C:inactive} Mult){}",
			currenteechips = "{C:inactive}(Currently {X:dark_edition,C:white}^^#SUB{C:inactive} Chips){}",
			currenteemult = "{C:inactive}(Currently {X:dark_edition,C:white}^^#SUB{C:inactive} Mult){}",
			currenteeechips = "{C:inactive}(Currently {X:dark_edition,C:white}^^^#SUB{C:inactive} Chips){}",
			currenteeemult = "{C:inactive}(Currently {X:dark_edition,C:white}^^^#SUB{C:inactive} Mult){}",
			currentmoney = "{C:inactive}(Currently {C:money}$#SUB{C:inactive}){}",
			currentxmoney = "{C:inactive}(Currently {X:money,C:white}$X#SUB{C:inactive}){}",
			currentemoney = "{C:inactive}(Currently {X:money,C:white}$^#SUB{C:inactive}){}",
			currenteemoney = "{C:inactive}(Currently {X:money,C:white}$^^#SUB{C:inactive}){}",
			currenteeemoney = "{C:inactive}(Currently {X:money,C:white}$^^^#SUB{C:inactive}){}",
			
			bs_red = "{X:red,C:white}#SUB{}",
			bs_green = "{X:green,C:white}#SUB{}",
			bs_blue = "{X:blue,C:white}#SUB{}",
			bs_yellow = "{X:money,C:white}#SUB{}",
			bs_purple = "{X:purple,C:white}#SUB{}",
			bs_faded = "{X:dark_edition,C:white}#SUB{}",
			bs_channel = "{C:bld_obj_filmcard}#SUB{}",
			bs_mineral = "{C:bld_obj_mineral}#SUB{}",
			bs_rune = "{C:bld_obj_rune}#SUB{}",
			bs_ritual = "{C:bld_obj_ritual}#SUB{}",
		},
		asub_defaults = {
			baremult = "Mult",
			barechips = "Chips",
			barexmult = "XMult",
			barexchips = "XChips",
			
			tarot = "Tarot",
			planet = "Planet",
			spectral = "Spectral",
			code = "Code",
			
			diamonds = "Diamond",
			spades = "Spade",
			clubs = "Club",
			hearts = "Heart",
			
			edition = "Edition",
			dark_edition = "Edition",
			
			common = "Common",
			uncommon = "Uncommon",
			rare = "Rare",
			legendary = "Legendary",
			epic = "Epic",
			exotic = "Exotic",
			
			bs_red = "Red",
			bs_green = "Green",
			bs_blue = "Blue",
			bs_yellow = "Yellow",
			bs_purple = "Purple",
			bs_faded = "Faded",
			bs_channel = "Channel",
			bs_mineral = "Mineral",
			bs_rune = "Rune",
			bs_ritual = "Ritual",
		}
	},
	misc = {
		dictionary = {
			--b_TopUpLib_Music = "Music" --what
		}
	},
	descriptions = {
		Back = {
			b_topuplib_infinit = {
				name = "Top Deck",
				text = {
					"{C:attention}+990{} hands and discards",
					"{C:attention}+9e8{} Joker and",
					"consumable slots",
					"Start with additional {C:money}$9e5{}"
				}
			}
		},
		Joker = {
			j_topuplib_infinit = {
				name = "Top Joker",
				text = {
					{"+#1# {C:mult}Mult{} and {C:chips}Chips{}"}
				}
			}
		},
        Sleeve = {
            sleeve_topuplib_infinit = {
                name = "Top Sleeve",
				text = {
					"{C:attention}+990{} hands and discards",
					"{C:attention}+9e8{} Joker and",
					"consumable slots",
					"Start with additional {C:money}$9e5{}"
				}
            }
        },
		Stake = {
			stake_topuplib_infinit = {
				name = "Top Stake",
				text = {
					"{C:attention}+990{} hands and discards",
					"{C:attention}+9e8{} Joker and",
					"consumable slots",
					"Start with additional {C:money}$9e5{}"
				}
			}
		},
		Blind = {
			bl_topuplib_infinit = {
				name = "Top Blind",
				text = {
					"Maximally large blind"
				}
			},
			bl_topuplib_debuff = {
				name = "Disapproving Blind",
				text = {
					"All cards are debuffed",
					"(Click blind chip to",
					"change card category)"
				}
			},
			bl_topuplib_notallowed = {
				name = "Prohibitive Blind",
				text = {
					"All hands are not allowed"
				}
			}
		},
		Partner = {
			pnr_topuplib_infinit = {
				name = "Max",
				text = {
					"{C:attention}+990{} hands and discards",
					"{C:attention}+9e8{} Joker and",
					"consumable slots",
					"Start with additional {C:money}$9e5{}"
				}
			},
			pnr_topuplib_infinit_mult = {
				name = "Finn",
				text = {"+#1# {C:mult}Mult{} and {C:chips}Chips{}"}
			}
		},
		TopUpLib_Music = {
			collectionfallback = {
				text = {
					"Key: #1#"
				}
			},
			undiscovered = {
				name = "Not Discovered",
				text = {
					"Find this music track",
					"to view it's information"
				},
				atlas = "topuplib_common",
				pos = {x=1,y=0},
				soul_pos = {x=0,y=0}
			},
			music1 = {
				name = "Main Theme",
				text = {
					"Balatro main theme",
					"By Luis Clemente"
				},
				center = "j_joker",
				order = 1
			},
			music2 = {
				name = "Arcana Pack",
				text = {
					"Selecting from",
					"an {C:tarot}Arcana{} Pack",
					"By Luis Clemente"
				},
				center = "p_arcana_normal_1",
				order = 2
			},
			music3 = {
				name = "Celestial Pack",
				text = {
					"Selecting from",
					"a {C:planet}Celestial Pack",
					"By Luis Clemente"
				},
				center = "p_celestial_normal_3",
				order = 3
			},
			music4 = {
				name = "Shop",
				text = {
					"In the {C:attention}Shop",
					"By Luis Clemente"
				},
				center = "v_clearance_sale",
				order = 4
			},
			music5 = {
				name = "Boss Blind",
				text = {
					"In battle against",
					"a {C:attention}Boss Blind",
					"By Luis Clemente"
				},
				center = "j_matador",
				order = 5
			},
			cry_music_jimball = {
				name = "Funkytown",
				text = {
					"Holding Jimball",
					"{C:dark_edition}Copyrighted{}",
					"By Lipps Inc."
				},
				center = "j_cry_jimball",
				order = 1
			},
			cry_music_code = {
				name = "://LETS_BREAK_THE_GAME",
				text = {
					"Selecting from",
					"a {C:cry_code}Program Pack",
					"By HexaCryonic"
				},
				center = "p_cry_code_normal_1",
				order = 2
			},
			cry_music_exotic = {
				name = "Joker in Latin",
				text = {
					"Holding an",
					"{C:cry_exotic}Exotic{} Joker",
					"By AlexZGreat"
				},
				center = "j_cry_iterum",
				order = 3
			},
			cry_music_big = {
				name = "Final Boss (For Your Computer)",
				text = {
					"After a hand has",
					"scored {C:attention}over 1e1000000",
					"By AlexZGreat"
				},
				center = "j_cry_exponentia",
				order = 4
			},
			cry_music_modest = {
				name = "Modest",
				text = {
					"On the main menu, with",
					"the {C:green}Modest{} gameset",
					"By MathIsFun_"
				},
				center = "j_jolly",
				order = 5
			},
			cry_music_mainline = {
				name = "Mainline",
				text = {
					"On the main menu, with",
					"the {C:red}Mainline{} gameset",
					"By MathIsFun_"
				},
				center = "j_cry_fuckedup",
				order = 6
			},
			cry_music_madness = {
				name = "Madness",
				text = {
					"On the main menu, with",
					"the {C:cry_exotic}Madness{} gameset",
					"By MathIsFun_"
				},
				center = "j_cry_words_cant_even",
				order = 7
			},
			bunc_music_virtual = {
				name = "Virtual Pack",
				text = {
					"Selecting from a",
					"Virtual Pack",
					"By (unknown)"
				},
				center = "p_bunc_virtual_1"
			},
			stocking_music_under_the_tree = {
				name = "Christmas Spirit",
				text = {
					"Selecting a {C:green}Present",
					"from {C:green}under the Tree",
					"By ThunderEdge73"
				},
				center = "Santa Claus_stocking_present",
				order = 1
			},
			stocking_music_silksong = {
				name = "Balatro Christmas Drip Music",
				text = {
					"While {C:important}McJimbo's Grinch",
					"{C:important}Socks{} is active",
					"By (unknown)"
				},
				center = "ProdByProto_stocking_grinch_socks",
				order = 3
			},
			stocking_music_list1 = {
				name = "Relaxing Playlist (1)",
				text = {
					"A possible track to play",
					"when using {C:important}Relaxing Playlist{}",
					"By ProdByProto"
				},
				center = "ProdByProto_stocking_list",
				order = 4
			},
			stocking_music_list2 = {
				name = "Relaxing Playlist (2)",
				text = {
					"A possible track to play",
					"when using {C:important}Relaxing Playlist{}",
					"By ProdByProto"
				},
				center = "ProdByProto_stocking_list",
				order = 5
			},
			stocking_music_list3 = {
				name = "Relaxing Playlist (3)",
				text = {
					"A possible track to play",
					"when using {C:important}Relaxing Playlist{}",
					"By ProdByProto"
				},
				center = "ProdByProto_stocking_list",
				order = 6
			},
			stocking_music_alibi_christmas = {
				name = "Christmas Card",
				text = {
					"While using",
					"Christmas Card",
					"By (unknown)"
				},
				center = "Edward Robinson_stocking_christmas_card",
				order = 7
			}
		}
	}
}