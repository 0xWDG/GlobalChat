//
//  WDGPConfig.m
//  iWebTools
//
//  Created by wesley de groot on 20-05-13.
//  Copyright (c) 2013 WDG.P. All rights reserved.
//

#import "WDGPConfig.h"
#import "core.h"

@interface WDGPConfig()

// Make any initialization of your class.
- (id) init;

@end

@implementation WDGPConfig

- (WDGPConfig *) fromJSON:(NSData *)data
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

- (id) init
{
    if ((self = [super init]))
        {
            saveFile                        = @"WDGWV.db";
            
            NSArray *paths                  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory    = [paths objectAtIndex:0];
            NSString *path                  = [documentsDirectory stringByAppendingPathComponent:saveFile];
            NSFileManager *fileManager      = [NSFileManager defaultManager];
            
            if (![fileManager fileExistsAtPath: path])
            {
                path = [documentsDirectory stringByAppendingPathComponent:saveFile];
            }
            
            fileManager                     = [NSFileManager defaultManager];
            NSMutableDictionary *data;
            
            if ([fileManager fileExistsAtPath: path])
            {
                NSError *error;
                NSString *str = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
                NSData *tdata = [NSData base64DataFromString:str];

                NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:tdata
                                                                               options:0
                                                                                 error:&error];
                data = [[NSMutableDictionary alloc] initWithDictionary:jsonDictionary];
            }
            else
            {
                data = [[NSMutableDictionary alloc] init];
            }
            
            configdb = [[NSMutableDictionary alloc] init];
            configdb = data;
            autoSave = (BOOL *)YES;
        }
    
    return self;
}

- (WDGPConfig *) autoSave:(BOOL)val
{
    autoSave = &val;
    
    return nil;
}

- (WDGPConfig *) remove:(NSString *)key
{
    [configdb removeObjectForKey:key];
    
    return nil;
}

- (WDGPConfig *) setValue:(NSString *)value forKey:(NSString *)key
{
    [configdb setValue:value forKey:key];

    if (autoSave)
        [self save];
    
    return nil;
}

- (WDGPConfig *) setObject:(NSObject *)value forKey:(NSString *)key
{
    [configdb setObject:value forKey:key];

    if (autoSave)
        [self save];
    
    return nil;
}

- (WDGPConfig *) get:(NSString *)key
{
    return [configdb objectForKey:key];
}

- (WDGPConfig *) save
{
    NSArray *paths                  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory    = [paths objectAtIndex:0];
    NSString *path                  = [documentsDirectory stringByAppendingPathComponent:saveFile];
    NSError *error;
    NSData *jsonData                = [NSJSONSerialization dataWithJSONObject:configdb
                                                                      options:NSJSONWritingPrettyPrinted
                                                                        error:&error];
    
    NSString *backup                = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    backup                          = [backup base64Encode];
    
    [backup writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (error != nil)
        NSLog(@"ERROR: %@", error.description);

    return nil;
}

- (WDGPConfig *) makeConfig
{
    [self autoSave:NO];
    [self setValue:@"q_CFRPamU<SG8m01wFcbm774CI4SgexH71eYRpdDp>bxkczRRL+5S2anLe7-tEABG000" forKey:@"Psp6F(wE6(ZiuI27D8_Gifjxnc-+NuAvW_CuV00-(ZcqAfy6nqMGG~6)a<YYtqmhi000"];
    [self setValue:@"YM6ZM0UEcd7sLdP4_oLYuH0tyZXYd793Tg+ygP5s(cUHqCLj-p9n<aRx1GoeNyizO001" forKey:@"d<)(4pYhcxHOb_IA2~zcP>dnns3VLCBYBxTGWKX0awPlppWrnoD4nRsKcvxX<0NBy001"];
    [self setValue:@"z9mc<nmw5IVuwfSUTWaCgUOMjELkkfSTo7>oulUz(H)sXOfIDpdUb+yvybPSqAEPH002" forKey:@"C53XZCTzzdofs<TScF(65rFg9pHJ(piyvlnnY8WqmdFOdqzp~uw3W3j~s-GojYWOc002"];
    [self setValue:@"c43l-tH61ojsXJqk7t8bN5EHM+_DRHQ(LThEfYLhf~K5G3qOwy_cEwUjqMWamE5<q003" forKey:@"nEGdhYtfAzWDZC2pvf)-1fkN4u2IA11XGH3Yxx50>-DXwGf-VbUWr6CvBE53G6-eO003"];
    [self setValue:@")4dt9dr3RhzpwscHf11lDwX9B_QIU)pQ1DcbREeAVN_j75-m6+IJqyT+rBDdy+(zy004" forKey:@"8KhMYRADKULPN0WIJx19j(AUzNluJU+Rwbwn(>-FSEnyFb8gJ9p+5ZPFF21gX)0m7004"];
    [self setValue:@"xJ2wCIh9~PP9Y~S0nN5fuLUxM3mI3IQBkT<Xug>s>NBWLlW00+fvF2+k5h(9ZLKbx005" forKey:@"J0-_<lYNWMqaBravGG3IBoOSjXJ~zVubWn3VI+BwH-GakRG-qKC-0iLj7ngHaLT>0005"];
    [self setValue:@"XUIRn7qhOBCy9wYT0SUiv5qSm0(<T+0IPJs5QSmxlZ~vnWhnH3G49<Xv<SvSNwtu7006" forKey:@"VzYGWo+Nmp3aHrRK<WT<Mh>xNRcbcHj08aH~yBKU-O~A7Pc7D>6ig5P(W-71Ar2JB006"];
    [self setValue:@"JG1cjV6<SG6ATd6Sko0p5(e>3gzuia~+R>62Ud1FT87FldpGBp>HlcGot7SLiQF1P007" forKey:@"M4BZ59LdhjzuI7>06GlieKMmupEd~G+KKvCQFg)WzvjaDiaJYw+48GqD>~Q)DKHg8007"];
    [self setValue:@"c<Ns(B+qU4)4eF+KA<T9qo8n65-QMaZZ9Ej47eu+ir<x<+az-(JjjRHpWB8BL<sUE008" forKey:@"MYL_lGbMFIMzSdsNXM>HmowXx<Axsn36dO<znae+S_tC6Wi)BgDXF1M41eBtBEAPl008"];
    [self setValue:@"zhIJwDup<<vVhsoy~e5>_a07LtJi(rEvIf77SBwRA+FRm)ikani2xjabMTuIc06Vg009" forKey:@"d+0OqShlq1Hmj-wGcz6vKiavNTHOZv)4p~TQQ2383LunE-(Rt2e5lpB0abO2GK6>I009"];
    [self setValue:@"_Oq(Sy<v(m1XiTjk0pGp_Gz4nCK0IJIBp0wazvFvRHk1sEms(+RWBj_YVCZwez<DA010" forKey:@"wN2-lxK+SMno0Pj(z8wT0nHDe6RO6nhC3jvoR8jBUGZVobQYjfKjCkXRqGyx(P1>1010"];
    [self setValue:@"xnTGGmteehDq<tJe5(RpTAQr1fnQhlSPIDnh_Rv700x0u9eA5>ZYzIiAXFj7-4WCI011" forKey:@"cTB(hI)i8)Mhben96dIOwbE3vL)zAz9MkKIClEUtAyLLN0UTevAKH6N4SKDkcN<wq011"];
    [self setValue:@"H1LdV6OmRr2ReV~KoHjvnnf0-AcGzJ>9KJnxQ3UAvWjKKhm0ZGwf(LfXesvO3uYN6012" forKey:@"ddWh0oNWIpy_LzSj~<fJe4YHAEK)uq3ID_ZDgEsZ)-SHsC-qB92Qd_pOw1L-sOC>G012"];
    [self setValue:@"tBX0)O)XyEi2xIEGKmUCLB1Ne(7+x5B-Hq-E7YtGvLJ+lfB>BoBfZD(5y30~8BZQ-013" forKey:@"Tm0JQH6ti1PxDO1+hgTUcZlf_jota7n(toFc~LFfNnNj3Odl~<89ZtoRMNdWUBSgZ013"];
    [self setValue:@"psX305RoS2sygNvgVE7h(Z(J5SvGDMy+7o>8tPwdSYL0E9grNoJJgEklpQ+(vtXCR014" forKey:@"WKdD9qn<4oDdE~-(GCbdXxDGsy4WoGFcjTPtb5sft>t0)m(CZ7QPEln<UrVa0tnke014"];
    [self setValue:@"4Oqa9GD71D4nzHfGp)dLkcxM<INt~0I2O0cXGP~Hl1~UIct<9GKtSa7SSUdPUVSAW015" forKey:@")quMn40o2U>ef>oWJRGUZrELFmys61h3rLPPQP5SC4<S3nGM7fz>G5JdsaGzbXCDB015"];
    [self setValue:@"kkk1q4Ev4pyr~dydMwTS8<diFMuvh0<BljDMn99szITwWkKBRwlZvya3dFzuFy~-S016" forKey:@"BF8LOAcplJdGlOpR2gfBriP>RbEi9x2K4anTKza>aoEw5(f8cvJDNqBxC7QLFSoJ(016"];
    [self setValue:@"MvGdGEo)bV262ajxUWddqLQytu5eSO9wcPKSm1PxWREZ+XpPMC(4fLCJ8HX_o>pAO017" forKey:@"1k231AZT6QO)7vJJrNZ5iAdZp6gowR4x37A5HsZOaFLh3m-v2SAklOcLUs1ib6Qfd017"];
    [self setValue:@"jlULcBWSf5WB>jDRUX4A2PnuRGGXpW2JaXnnrb7Gg)9ffN>1D3CFS_1ByIqYxtzHi018" forKey:@"W)J04hg0rwf6uhJxUgiMiUd-d3qGD0Zs)As0SJ0c7giCy+2lbk<u7dnkhO-UPSeLl018"];
    [self setValue:@"HM6iNip)B-uv(PHgP3n(rIc8B>XmdBHUfN4+>uYzol~k3EATIYO1y_92Z<o5A>_PM019" forKey:@")KKrBbPX91_NCMnssp-lz(dyki0iaQ)7tHz)TgT+iMHUr~fTm97V5lmpEnIP6EXze019"];
    [self setValue:@"ov<Fh-Y)BKnz_9V1hJ7D>w9l6YrLO_Z4oYKGSADld-U52I7kkeXiL>ESX~vDYnIfe020" forKey:@"kV>Vrj0k66nPdH1swj6vXYlVmZMKz-YUPWH88HtfNQ)-p~mWhtj7kE(HwHj~A9Si>020"];
    [self setValue:@"sq72TnQBjK-h>Pys1GMFBl3aE1LOU(NemVg7a<JtJCLIkc2lSP-m2)wH>aoT54<sZ021" forKey:@"gz1gbvZO8z0kCl5jermbY(a0k(6o(yfc0hscNj_WT_9neeGtG+EwYPxaKEzG4PS5>021"];
    [self setValue:@"chLwazh2IFhXdKv8h+<>raJ~Jh2q28pfp3LzD(CdAT3OwyXNsWMU<nRJFU2H+rWkv022" forKey:@"AU0wpe>bhNHPCnar1)rpO2)B4EwwtQ-(D-r+7q5p6N7J2h34eut(xqwB~(0qL+mhW022"];
    [self setValue:@"Ob(6hld)sW>JZ3YlxTTYinVdneZhA85gk1nBnBxPpwqgzhC>2nXlKKy0YpiryoISq023" forKey:@"~lNySuYhV7R4JP7<EsKh-L8j(zRk9BK7XqFIUwZIDINfqUf~fZf9DnszWcT~Nv4DW023"];
    [self setValue:@"KdI85jMN>-6T8410jaDGD4uPYsvmw0a9dSii4)>2X4W>8X>r0C0DGvkxXPTmP(v(O024" forKey:@"NdSJcUzgIxpyvRy<S3Gfn645ZqVUVQAB)kc87MpPbPgGyOGiRfx7lCdd+0<QQzjNT024"];
    [self setValue:@"wV-adIl+Y+tFBMoRbw5OJiIJhqsRK7D8(wj87E3>zwD2a+UmqZ22aLMr46bOeOXac025" forKey:@"8ijNlieRVh+P3g8+ja4)Xw0(HOaoEkAMDUrY4GI_XCH_TQV4-_0Qp1M<QWnm8Y1MK025"];
    [self setValue:@"tCP1dHYQhRC<FG-yHJXInXqbcMk3N>O9BvaP51xnT1nqIgZhZP_fEirR~MULKAUe~026" forKey:@")(3>tqRvNa5)1nVQf3nyu6v8_8Ts(0q_)tYpUIVzS-wUgjDwn_~R>s_YBLiwLIpH4026"];
    [self setValue:@"f<YXUqIOWu)8<tvZqfYT7OnS<TwIb6Mq5Dg_(ZGSmD_l<odpD3bKSyuRk-rv<6W5J027" forKey:@"4~F)Epi9iE8GRybVJVG9iptcRYbYMgzRe7NSw~-OC2nlAy9bmQlE8OQZF+Qkbi3pp027"];
    [self setValue:@"RaWP4Cj6ZFGqPSMx5jFU2xr)fL7xPxXyHLfLgzR86qyVbdlgw_2ypuuF7C5W1+nJF028" forKey:@"DnV46(axu>IHjZ5c+DBo09wCekE8IgOdDBhKxs9-rSBKKGWEcq+dAqQOLnXmDDz87028"];
    [self setValue:@"QSEb+yCM1fpI3(VuY0)gQL+5AgJ6PRdyCSKwiebktA(xvR+lRYCACxG4Nibv1o)D8029" forKey:@"H2rVdMhOIObrJxbA2M4zl9fDkLFJIaShdb4qYm6z3i_MQ4eSQij4szHMcenUp83Cj029"];
    [self setValue:@"8(au2JykCc3GqVoJ7t3G2QSh6FHeJcyR7JeakMvWZyuhlT-te~1hOUzVr813kAUsb030" forKey:@"1CvO<kFxPXTBReQOf<v2yiuHkx-Ukl~lYt1XOHnvw8<fmP)CPrEgJ1X(yRQS5N6(9030"];
    [self setValue:@"8SYP7legltD2q7SRM0tNXpeH7>MV5H~dsV(A99QuDlw(tgN7h9V7y1OG0st52rjue031" forKey:@"e)nnNR-0gWtxCBOLoVbqCSq~dw<EPuT(r8j6_c681AGD3nhratRNdaKrGK~n7RjyZ031"];
    [self setValue:@"CFSOL-QdzlgWCI<>sNbCpCa2Ay9jRIblf(2-XS7p6odJ>dHq_S(im6lXEu8o5kJkg032" forKey:@"Me5xluDJIfHWW0PH)<)2lTHQ+~VeH8ulmASH)oiFD_ts-b1Xb~_wRzeLx1Z69mswW032"];
    [self setValue:@"d5TBoq7hUAb~B18z-FitT(_VV<~9rt~EzR8Xag7)Qi+kk3TeI4Iu<AhVAe)-H+y9L033" forKey:@"H<VY6SGpN-KQNYrRyWR15EBkBv+v)39E2~u9Q3yv)beJ1GtzucBzR4UkAOQxRZ3UX033"];
    [self setValue:@"x(FBu3yFh9HYD8kPKUyPGShnBO6tS-ihWYTj+jZcsy2>GmNj9e0P<h4A>b(Q5e0+5034" forKey:@"Td<44bxCevbAbuKqurpMw_LIWtN2uH7fV7k_iSuwfG<r3JRx38cA1XbXjYZNy<(m6034"];
    [self setValue:@"gep0JWfhWHkxqSBz)4AUfq56hTEhO-o~7O~QCd0qUkYc5sM2wfWLF-RXNo6uhvrpb035" forKey:@"o7NB86ot~BypfAVuoz2iiZ~G>sYtTfF9nkLvr1YoCpNSZBfg2hzl9x+8ZSCK09Unu035"];
    [self setValue:@"yTVAKb51ZX-t59wnJRw8LF<w9KwixUM>FAyhMDjEtc<ymvV~ek5__5o1QVkgH<eez036" forKey:@"MweiPSL+Rcgf0duljmdpLe8yzo8yCn0hTezB>dvQpL~pZrLbOYAs5J_E<14Bo4Tai036"];
    [self setValue:@"kLhx9<WU)eMoZX5QqxV1qs1rwDQBo_UIE48N3~A0bep34uTv-Hxk1zLy4u2tmW3_-037" forKey:@"cG)98~knmosRaYLRo~SXJj-5lmsaql3D-<M2~<qjnT3xJOh<M2XnlQtG5VQw8T12T037"];
    [self setValue:@"O4QNv23g6B_US_yUPW7yhNE4v3dh5f3TkTyPWC>+5ZPXRgJz4R<lxEq+HDcMSfy41038" forKey:@">UYBSTGJAvtQ7+VZ+8oyyj83vVWLl_MkNDVyotaZZDI<xvYsDf-4y18)W)H9XmtCZ038"];
    [self setValue:@"h2gKc8CQQBgdsIRHBW7D)3r-LBQ0~l_eo8ZBgtj<~zdpa~>MT6hQaJJWdrWaMOp3W039" forKey:@"gE5JX4Gpi>Af~e03wRe7s2kTYvyEUBt28zM>ElnWjY3g44kAVyIfA+1qpA~b4qec_039"];
    [self setValue:@"_bwezkypoOtt1)gzEw2zysY1q26RgjJ9u7o(sWkRDOcEKt5h_7QrAHs-JyK_Rl2et040" forKey:@"q9WetFSaSoUeu47CUy5t->5sI~c)0qpqAdF)Tp6EO-Sa~_MRrRdkQiNqgZmgiMHSZ040"];
    [self setValue:@"fOLFUhlN2wL(avm+IGK-m3adqrw41g(g)HWRZ9x-GaWQFbLgSo96skjSLPWM>S(+r041" forKey:@"RMj-bcAl1j_d)9~lj3NDnxh5m)36Z>yJKRDV)58>o1bla8Hucm<zUgE9dHf4GOOix041"];
    [self setValue:@"k6upfsOgE2rNJVZ~VqS4~-hE9mdX2vnnCRMRct0Qvrw6fn43NW8KQphZMvPP_44vV042" forKey:@"Re0ceRHGfOWCSZiH<+qpci3H<SA3X~ZGcZSqJs>Y9Vs+MKBMF+3Sc7sbZ+fO_6n4>042"];
    [self setValue:@"8vHAuyKh_E(D8Ia2L+eSnqKhFraMOfLWKlp7T1oLFkgO+rQGm~qJn3-(u3Hbik<(G043" forKey:@"o2rqq5>LlMGNue1sELPIEK4Hkf_FfVdEXE)gJ(+~HAK4OMwlpe((Z0DbfvRui)18B043"];
    [self setValue:@"~pc_jaATUEAz3VYhRU9Rpl<U4u51veCsDOlXZVJLscdv<3NRXXAeaA1f)7grlSUZz044" forKey:@"8Oq)q4oChUClAlbqWpAprQly>MURzLiHsJDSN+n~P_jheuH3Uasd_NMZsyI-b_BDB044"];
    [self setValue:@"6oh1MfQEy<S+HVPSf+L(GCn6chi4SVGZcY_Y5IvEIfzi2g2ibNdRhAYtS8yC)6t9~045" forKey:@"l03(vHEK9WNqY~BEalWLchvlQ0hXtqUPqXLVxhyH5d<)aBAlWo>1GumpuDeX)0FnY045"];
    [self setValue:@"ibozK~EX~B0y4lnsko1OKqagE0dFFBwXMUooS(ePxefBzD)T-~AEoKU(K<BiB<7fU046" forKey:@"wEEsTlZ<Btz6pl0mVELyrGar9t+9B9(<OAszVkzpN0w5mws925HtMSUWdP~PY-PFt046"];
    [self setValue:@"97huGGaH4f(BH4DMM<qxUfLBcss590zj7QNNoXnt4i)MnAr1ARzm<cYbFjhOjQ<qz047" forKey:@"N6YCtjHLgm1QN3ixCFwPwHmPZ20I2r9Py<k-j+FzgGi(JBse8Y(Fyimpln0nP95f9047"];
    [self setValue:@"q8tkO+Bmdw>OZdXP9ugrRFM7G2WQ83ZyclT_gmftSe9Jr<rBuH+dfHkWJ9ERdwhpR048" forKey:@"2i<pys9MCT6BdH>VCb3bwZVFvES-WaKZsKg_4qFHcMbql9dYlh1R8XpDuaxil9aNU048"];
    [self setValue:@"rGYSey~_JneTB46S6X_)fwqq(IL5TrZd0Q~eh+7_ilLTqRExHxtX)UfZv_~gjXtjG049" forKey:@"ryXlFQE_uqje)RVudKq<_iuSfK456nLxVBTtjpmNPF-MpP8CszBkR~5<I94OxQelj049"];
    [self setValue:@"<ODp2i6HcT>-+Blt4Gd2LcKUhrk<GFjGlW~n74~jX)cSxydC6qESDhEUJYUiw6YR+050" forKey:@"V71_4kP1xAz~N346IWK_txCkjUQqKzkyHmqLH8N6Ie4oi8v-~7UqEoKYasgV+BlBX050"];
    [self setValue:@"MfxU(Eu9JSsRfmPn87-wRRHc0v7BRJrvYYhTvL(6woYMKF1SM+hwMZJMmQg6rHBiy051" forKey:@"S4(w<2+o_H0xITbD3Ih+j)h1dntVYLlJPh8Pj36bK7Ik_UX)u7ZO39Qhwb4nXq<FH051"];
    [self setValue:@"7n-at5UBO7uB)q>3hM7quoXGsdwSc4skrmuVrho8oTJkbHotmwURVKqgXW12-tmlQ052" forKey:@"R8a0xioi+JuB<XXwKHjm<zbWAeP)A2NjbXkI8I-2jnDjdtQY21c2BoY4CF15HOpSE052"];
    [self setValue:@"JtMjnODLkXYOFPRH-TbhJfUhh_Z>hKC-5gds~R5hG)~dLPVFA>XcdKtvCltU~~N2e053" forKey:@"-vcKBuiyswc9kRJiHVwjh-VCmIAkoCzh0L-C7c2zJfJ(>kdF8JZqDM(_nvdL0M+0q053"];
    [self setValue:@"WDy0F0KUJFT)Tr4uiv0~q_kV5>WS_WaPrJP<JsUl<GhS<mfiRffa8A>eyU>rJ983T054" forKey:@"Y2uiXQhv<2umiN6y+gGveV(0UnJ)vMPlPcDE+V2+Yxg8cmG6CeCR2xSWVuSi9zEYM054"];
    [self setValue:@"9vG~xAV)R)95CgIRSsTicH5GsnP--GF34e1BPXyyTHEnXf6IH__Uz~s-laVfRtjVH055" forKey:@"lppaXX(xujnJq~jiY5SWyMaJAps(JfD)E+6uS2-emhYNf9~5eQ+Nu4o~uQ-5~w2Cr055"];
    [self setValue:@"8>cb_qx9hcpqavF-pkouIlYqe)oK>_47ZgiRHQ-Y(ih6NW<58nzQIq9WmyzlqEsiV056" forKey:@"L1ut(lpeDw+rv<ATzjtZsie_Szjo+BcFDG1z+qNxWHZkHr58Kz05Rf>CPh-JT5gpM056"];
    [self setValue:@"iYGJE6yd~SUoY(1p)69b4L_mEB7JSxn2o)L+2b80)(oUYqbVwk>B>YXCs~dduBfTx057" forKey:@"-NA4VA1QZVHh>uOjthhj6UM4<ZyB7j00<A5U36D+-db_HZc29tmff1jf_SQ<4R04k057"];
    [self setValue:@"5Zncui5Ht>hlajuEGKUH)2APTAUCAYXGPdScvXUZW3c<nHD(kpDhr5>dGTP8KFOrS058" forKey:@"zEgpq7dukcS+POf7jwzpvM~gu5_2UkVlZ3KhbYMw2wqScF_w4rVz6SPBYIDL(q<Uu058"];
    [self setValue:@"K4FAQ3Dfuns2gY6ILFOwnin>W1-e1NJLRheAlRPP79Sn0Y~MwMbT)ySSAL<BqJfa_059" forKey:@"uLddt(lCNIDDGh2lsWi-G2tj2~KLdVEHyRV-M8wsR1~qi0LLW(Eu>0O0>qMbeiTM2059"];
    [self setValue:@"GGOP48y56Yo7B1(xGpvG6wFxbRLuCqwb>d_2mq8thwATyvi6VON-ckqn34RGugRst060" forKey:@"JuP2Caj1L4z8nG)3mXfHgDLknjOD29<MDPO8_09D5JLsiIwFxMeOhZ0FaPbdZa_uZ060"];
    [self setValue:@"HDRHNnNp17IJEf8itWzkX7vFiJwsB-kaw4ScrxBsFb3bqctT1(6Z2Cwld(OOX0Zl4061" forKey:@"Jyw81YOd+ZD6kp7gw>i0vDeqj+fkUBpv1VE3MkgGcUMxcTNIS>JfBXFVSV8Eox2ql061"];
    [self setValue:@"Ht<+KF6wkDJ5ijXg(5SSLGDyOaXedgzUKzPm6VTqruwKOm-JrLu4k<D1asgnIPakh062" forKey:@"ZHnMtO6XdQDzJf-nK>IKCJU)_9FHk_ZbAfY(()S8NoIpECMgBn_5>M2YWHy9Apk3E062"];
    [self setValue:@"b>A8RJV8kcMWZ(peVvdAx3p6CyH+TKz)J24tL_B>4gV(bca<HnA7r_d(rVYcyq99s063" forKey:@"eD6664an_6y5gyND1U~-0-lVRxmaHwCV1J-7O4uGa(Lruq~wc+pcVL0FbmPSTkFU)063"];
    [self setValue:@"z+LDpjOk~8Po6dB0DOWgOur3ccWwSJtjD6X+qDfnM)MSafTN(H)K4oNgACMkd8EQe064" forKey:@"tLE<_+LXGv<WgNRYKt+09aBLXVY~sHcVkRVdMy2l)29dP_3rm>sv9(8>R<)bG9<--064"];
    [self setValue:@"U6Fl8_hb1v_+zkhxNMHIVGsVCDuMDnFqtdLC5(N7qG2_-jqG><hUFJHaf3WTrubVH065" forKey:@"XpNS5UbLX3F8te6sv-07AanE<9>ukT39bQ+gD5+s9zBDNI>bB>j48HJ8QHC2tGcEp065"];
    [self setValue:@"7U+dOnmgYZ(zX72Vq7)<Q5PqHSTf~pE4bzh_XE8Ov4flci9Cp6C7bkxS5j02IF7U7066" forKey:@"pM~(VLr__M4aWHA+cH5w7YBqZE1xMVE3AB<neqg75li-(SV7s-EzR8_JM-8rPNuhg066"];
    [self setValue:@"tFvUVDZ9VS4GGc0AQAkZt(En3~4Rrl<V_vHO1yYXj(v_7wsY>MPsHlPLjTuK7uy0_067" forKey:@"7O-GFQZAeRIKczJYg3yCScVEHyL4<L)6sYM<HEAVoayAJ9r_d_v>5jCMSgQR-NXmD067"];
    [self setValue:@"Clc9W0x<y0JIsCVl<Uqjp43FVUyAKU6f8jo~jW)RXFriafD91(sq0w>Viwo(jvasO068" forKey:@"zp<omRd+bw4q1es~HT~5RTogajAFu+l(kljH4xBf)FG~U1+tU_yDLWUV7msChOxC1068"];
    [self setValue:@"Rb6hMmdk+b6(6zQ<0mKW8y)v-yMH>hJQsQ<74ds<pz(v1Lu1<7Y7FUCylh8jyS1-A069" forKey:@"11FftEE+z2)cw~bEVjcIWL)6TgEEiy6jzLy(i4YR7U)DR7aFrmgg<cmTs-pKrw)-9069"];
    [self setValue:@"vWrAMbHz7djfnYGJ7XJjbuM4UpwilpsReUj-~_s45LksC-4JQO(-bI~~<uglTI4<v070" forKey:@"n-sglxl<ROCKTetzamLSkJSOZ6AAbA~ztqPPY3PIRjlDxO5H2Qsnrd4jjETu7R)A9070"];
    [self setValue:@"Li0P<Izi(4QJaqM_T1k>5EiJqNQ9JjjnCj4B-DUWICyS(cLOd~NiC~++KL3l~mJzG071" forKey:@"N3AjXp-sXLo1o4fmSyYPtSr7WN4boER4HjnwJgZy+fAikPF4fwTIgdP4-Ughq<m<j071"];
    [self setValue:@"Jw+_otUD(5XKL-_9NBq_iuT5K3vKpv)1+Z-ikOVfUL_xESHjl<bEu~J617RqDNsxE072" forKey:@"mQZ3D6Xg<nVR)75(iKpglwhtgI>(2vAodrsRyh0xFWhB(nxe<XulmMOCmMypa0Oos072"];
    [self setValue:@"88_p9q~~Hy_)>6)VAh9e>MBLc_WcGcFPly6uY4ryDkvBqrp-Jz8HdJkpC8Cbl9_HI073" forKey:@"<4y3w<GQv98Xz1y0a8dTtCnC6zYgrxYqBpt<p1PUbYJK_aK2iYVLsbfzL5Q4DGu6>073"];
    [self setValue:@"Y6n_W93MTOE(rHdhvZKH6bkc-oQATWzJ(WBR>FwRm3MNKZ)7QHOXS02MpSfaHOUCC074" forKey:@"nmA(SjhW~~yX+GGBmwlny0NjfX_(Jvy<S1(DldrjaZ84xPGUd-aL+X)aMX6okEo4F074"];
    [self setValue:@"kI-x1cI-kNr1ldffo_9dXj_Mph<)G4C_MvqNH0H+N0)1ebgC4qP-JHF1ZE>xJApn~075" forKey:@"P3FQKzwKvxYHNtL5aEPScRJQP9rhzPfhSU<ulv7R(>qJr3PCHxmTg>C>7)fGLvXwh075"];
    [self setValue:@"X-Dl0mg<M_qQH+p6hbnfNlnKB)o>UVfJOS~P7eOT67BO2-Uj4azSvXv>TT)GGcin~076" forKey:@"f44tTYA_sg+l3eqdNbICGHosE)0QfoOvsSYeJr73H2pKgPY)_yyz8X-MU+v1ibwL)076"];
    [self setValue:@"nZGP>Jo001hQZdIqM9yB3do~IpfUW_RcSp-R0hS1j1RbfsB-C2uFgSCYaSL>KuavU077" forKey:@"4eVl>WF0GQf0k8CnDaDoMuzw8y9DJFpNTc1S1GTIp0IK9d<NoD430Dz83JLMg3r2g077"];
    [self setValue:@"sVh1G_rHB3QO3w5GA8G5IP8jsVAvfCLIp(J>V2Fo6n59UaQmjor-6AcyoN)DiIdIE078" forKey:@"WGrZdQ~BW7n<XJie3bkEoT+4PxmqK))zCorQ6pj(wG+lidzmoU_NFURnk5N)2JwE<078"];
    [self setValue:@"Xm6eG1Kf)>x9yUykMd_z~fT3(Q5EeKE4<LjFM(UJ+kSs6jNTxGkuW6yRXDo4g+8fF079" forKey:@"rVknI(i(OL2<qVw<8-VfrE4~(8dYgtvIhQ>ZMgUs-XskKZjTS60cL59GdnwuQ+50L079"];
    [self setValue:@"3ZpjMSdBdxe4Q0XX11A6b9kyFOhAThdX9C8VnmpATEECEtsFv(MG4>7KMocyGqnP(080" forKey:@"wDiS+SEzp85TALhwpXAn~d1mpz+QXKLlg)5aPJK6SP_ls9RR<k6)x8iXIdFxXjT5f080"];
    [self setValue:@"Yg)A_2lI(G34qU3K-<a2h<LvEakX(q4UH0nz3Ia>hd3I06k+5u)nuHT0S5YOw(B5)081" forKey:@"YF0zP>Q+2q(8LXe8UCCunDetu(Zpw)lmCmVjkEem~9vI<JRTemfBZu)mpWLVT<anl081"];
    [self setValue:@">GGCV(z~qa)2-Pgf)S7qPtQD7Do6OLsMk1g7)P4nZ1qTQH0Nr868BWMJs2Q8NaU<b082" forKey:@"378TcwLdXw)wxKYFR<9GLS1NA9tL)tX0B>TNux-j)YQtBG1kGa-j(+<w4s91V>1p)082"];
    [self setValue:@"V4rk>LgXtKq2LLIWE-Sy_gDlqE9oFyltDNNBq)rTHRVluw91p+Aia5DAJMZhddKQ_083" forKey:@"qkinL4)v_hZor-Olt>wyC<9hYqu43c)txfQakMFc)xBnqhJTg7kS6t1~Uw2XJ>j8e083"];
    [self setValue:@"1jyOYLLof0OxJANRUyYgAW3>Y_HWcQ3d1C+_gFgvG~+ixI1k8_BIOEHExhtJ<wX11084" forKey:@"S-hp9M>6GgEgiZpas0Y>HuwZY7Zm~_nPTF7(j51_lG9DxyO_yEZ81n0ZvZesRC9D9084"];
    [self setValue:@"gytlAlH9ucH+-ztxqCzNCratGCdaMRk+hNgS1X-v2Bq(2Utso+8_mim+Vz5AipuA5085" forKey:@"Kl7AfCCQ(ySP-c5Wl~aEj5rTa-3AoEF1ZMB6h6XcEH+yU<m7~xLhC52M<6enLUpCz085"];
    [self setValue:@"_JR<y)D8Y3+Yq2VXO4rT76Sdl8Y8xtHq5rpEn(Me<H4pJZfp)Hb3N)h1489CCR(Ha086" forKey:@"leyg_MfzQFbIUBEtNI9J_aO0jjD3ecezqMQjr>T9D~SqypTd<(XZ5D_pWvs2IGC1l086"];
    [self setValue:@"kkMi6WW3GeC~0Q)(FW1aPr<dT2VsEXNZasagg>jWcVTdDQ9bFamnBlAnonQ+dwUnY087" forKey:@")D6+X(7LOkgxus5FOs81+wpiekvK6SA3oH~dC5Yjq7QUzWrfgAha>Htd-YX0Jq3<0087"];
    [self setValue:@"1dC63WwbFjKtK_JcaUbRfoL6eMPFPPFR+aY>>m9DGU<iMIvXuGGK~jQb>xROfox9y088" forKey:@"n7xKh3i32BQL>F7FeSCyAOw0xcfWJpn<xUJOY-S_vADt8L0mvDU>ki<SufG6E(53Q088"];
    [self setValue:@"PSGJCy654zdPAAd6nbqGaa3pQ9)Mf0u)S2FnBLsFdGmN9AUwLc4Wn7e6hbTwbft)h089" forKey:@"0jTMMqZkMFuer__E~P+5)1m7UTi1fejgy4+cuUw9s-oUThrR<lW(mb28~lacAus0y089"];
    [self setValue:@"nc(aJ5CCtooLP7K3)Fp7Iy4(Jhv5KwE<Iz9jELW02cLSjoVf(dnEMsznJ~tlt<l3y090" forKey:@"vn58b5boR(H7QX3)dHIF8>h6rDAqYEYl-(u51GtSB3_k-(g6CZMLX(RgyjHpXxLRt090"];
    [self setValue:@"7XvNjfhm7Cg3TnFK1iA)2RvmqVcYy(jGTPm4~Dr48H7-~NE>~6(0Yrmgey6Muqkf7091" forKey:@"Gk4cL9klhdi~Rg(Yc(ODh~RQ3wduQtCpNHBrRVM11)>Td-JpWq(6nNXrb2V-wqjb<091"];
    [self setValue:@"UCRIhSJeQurJ6RywMETrtdDw0x+rQ6rDJad_+X7LjynpiVW~sIpWV+kWrff9mGM~R092" forKey:@"_YLP~p1wMrPzfM-X3PK~2zphOzDneB66rSWp9XWVgDnwhgll>>j0yIieaWCopIuRt092"];
    [self setValue:@"i9C8~qpANVS)95+8p(G0eUa2oyr<(bsek~minLS3zD<IJ+Q0Yo04bb6zJyzFJ-T)Z093" forKey:@"8eeU<ilCh(dcLe22f6dqdN2LeHn8sk<AyemywH2ODg_gu(iK2v2gb4+pLhy6CxG2M093"];
    [self setValue:@"(BaDDZ8USphNH-Q5(>g0_GLa7RMEqPjmitZWk<I5oZS>SB4OAlOs-sD0ciFD<YZik094" forKey:@"Q6FPPK6Hv4s<98zuX+oiypuQ)<PVZ08H6OpWrvvWAXWK>n6Viu6QTByQBgEsgM1ns094"];
    [self setValue:@"qbTWHIpwx1uU8i5CoVoZm6tCKVTpW9SfkE4+fuqMwVyE5E9urymOFPjhC4HrdrHy~095" forKey:@"Msc8TYFGpcM(m8nUv4rcnJPri9FJR6HvyUEjKb_2oE>KMmw9qYmNz47SdMu)S3rjX095"];
    [self setValue:@">DA9vCy1BaOXHYfxc(<h2RuOdrzhTT6RoG-TbrVMBBBbrRIEMIVOrivFJ~WuQ(d6C096" forKey:@"7_NyNs2h)dJNWfrx38YlEw)CkrkgFrSMkxd0_fhWt_Bi8(Pb4GwI4tdpUyFrZq6cX096"];
    [self setValue:@"jcQztE(m7du3+F7B4QFx(~ktDMl(SxT3KBD67ysfLXiGvpaz7P<3Njxi~SePi<T+A097" forKey:@"p1IXtXBj7aOwkgE2fIQz70wZee9e04Oq5ofzeRTl+ASfQoh>>0x50)~fb7tccaChz097"];
    [self setValue:@"SRNCD1w5TMVa)T9)jf~gccrkGEwR8Oi-y>v3<+8TG((CP4y1kvhwIJRhff0o(jhuh098" forKey:@"NxhIF2gB>Tj3klnPCUqeDHuTHSP_2baQIsqgvHSts3xMoVu-HU8dtC<3nO)q_68Ay098"];
    [self setValue:@"zR(8BpBEWf(JJXjw~x_zx(WdZf5>nGxXpt~_SyxHOtjqiDWf2POzKDNCTTB9r0>Rt099" forKey:@")Kev9VbC7CUKq2M8ReSm-n8NZh6_fYmbAAHKoSevn17O4UWV0Ga+)iHVzONPE1-6C099"];
    [self setValue:@"AQ_l~oI<vo3hcYiT1dQjUDTBjA8lteX(~Qg(6Z+Cf>UsX4dYh(a4z(GTvO6Y()U_N100" forKey:@"3VT+Qo9PaBEePvwLFBdB9>>X5XS2JLPNzBHiZQ<1kEg21NOHg-bpZaf~<<<JLOoch100"];
    [self autoSave:YES];
    
    return nil;
}

+ (WDGPConfig *)sharedInstance {
    static dispatch_once_t pred;
    __strong static WDGPConfig *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[WDGPConfig alloc] init];
    });
    
	return shared;
}

@end