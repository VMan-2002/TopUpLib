return {
	topuplib = {
		collection_menus = {
			music = "Music",
			back = "Decks",
			booster = "Booster Packs",
			consumable = "Consumables",
			edition = "Editions",
			enhancement = "Enhancements",
			joker = "Jokers",
			achievement = "Achievements",
			atlas = "Atlases",
			challenge = "Challenges",
			deckskin = "Deck Skins",
			drawstep = "Draw Steps",
			gradient = "Gradients",
			keybind = "Keybinds",
			language = "Languages",
			objecttype = "Object Types",
			pokerhand = "Poker Hands",
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
				text = {"+#1# {C:mult}Mult{} and {C:chips}Chips{}"}
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
		}
	}
}