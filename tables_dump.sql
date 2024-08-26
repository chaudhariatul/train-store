--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 16.3 (Debian 16.3-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name text,
    price numeric(10,2),
    part_number character varying(50),
    manufacturer text,
    type text,
    locomotive_type text[],
    product_details text,
    scale text,
    weight character varying(20),
    accessories_included text
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    product_id integer,
    product_review text
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.products VALUES (1, 'Bachmann Trains - Digital Commander DCC Equipped Ready To Run Electric Train Set - HO Scale', 299.99, 'B000BPPNWE', 'Bachmann', 'Electric Train', '{"EMD GP40 Locomotive","EMD FT-A Locomotive"}', 'Digital Commander DCC Equipped Ready To Run Electric Train Set - HO Scale. The Digital Commander has everything you need to get started in digital model railroading in one ready-to-run set! It includes our exclusive, easy-to-use E-Z Command digital system that lets you independently control the speed, direction, and lighting of two decoder-equipped locomotives. Take control of your own freight rail empire with the Digital Commander! This digitally controlled train set features: DCC-equipped EMD GP40 locomotive with operating headlight, DCC-equipped EMD FT-A locomotive with operating headlight, plug-door box car, open quad hopper, wide-vision caboose, E-Z Command Control Center with wall pack and plug-in wiring, body-mounted E-Z Mate couplers, 56 x 38 oval of nickel silver E-Z Track, including 12 pieces curved track, 4 pieces straight track, 1 terminal rerailer, 1 manual turnout - left, under-track magnet with brakeman figure, and 1 Hayes bumper, illustrated instruction manual.', 'HO Scale 1:87', '8.55 pounds', '{"2 DCC Equipped Locomotives","E-Z Command Digital Control System","Plug Door Box Car","Open Quad Hopper Car","Wide-Vision Caboose","56 x 38 Oval of Nickel Silver E-Z Track with Turnout and Siding"}');
INSERT INTO public.products VALUES (2, 'Lionel Battery-Operated Construction Toy Train Set with Locomotive, Train Cars, Track & Remote with Authentic Train Sounds, & Lights for Kids 4+', 114.99, 'B08WCV1NT9', 'Lionel', 'Electric Train', '{"Battery-powered locomotive controlled by a wireless remote control"}', 'These large-scale trains operate in both forward & reverse directions and are power-driven by an easy to operate RC controller. Includes an exclusive 50 x 73-inch track system that allows you to create (3) different track layouts. Battery-powered locomotive controlled by a wireless remote control, operating headlight, removable reel load on flatcar, removable container load in gondola car, fixed knuckle couplers, authentic train sounds including construction announcements and horn. Crane manually moves up and down, rotates 360 degrees, features a flashing light on top, and is equipped with a chain and hook. Train Set requires (6) C Cell Batteries, (3) AAA Alkaline Batteries, and (2) AA Alkaline Batteries for operation (not included). Phillip screwdriver required to access battery compartment on remote control (not included). Wipe with a soft cloth after use to keep track and wheels free from dirt. Remove all batteries when the train will not be used for an extended period of time. Recommended for ages 4 years and up. Adult assembly is required.', 'HO Scale 1:87', '6 pounds', '{"(1) Battery Powered Diesel Locomotive","(1) Gondola Car","(3) Removable Containers","(1) Flat Car","(2) Removable Reels","(1) Crane Car","(24) Curved Plastic Track Pieces","(8) Straight Plastic Track Pieces","(1) Remote Control"}');
INSERT INTO public.products VALUES (3, 'Hot Bee Train Set - Train Toys for Boys with Smokes, Lights and Sound, Toy Train with Steam Locomotive, Train Carriages and Tracks, Toddler Model Trains for 3 4 5 6 7 8+ Years Old Kids Birthday Gifts', 99.99, 'B09FG7TQ44', 'Hot Bee', 'Electric Train', '{"Multifunctional Locomotive","Alloy material steam locomotive","USB Rechargeable Metal Train Set"}', 'Luminous Carriages and Multifunctional Locomotive ：Our Christmas train restores all details of a real train; The exquisite train locomotive can make whistle sounds and lights, and the toy train comes with an empty water bottle, and adding water to the tank can also make it produce smoke; In addition, the 2 passenger carriages also have a light function; Turn on the bottom switch, warm light will fill the entire carriage; This makes the model train toy more realistic when driving at night Alloy Material, Safe and Durable ：Both the locomotive steam and carriage wheels are made of alloy materials and other parts are made of ABS plastic, which are non-toxic and tasteless, and every component has undergone strict quality control, it is safe enough for kids; Compared to the all-plastic trains on Amazon, our train is partially made of alloy, making them more durable and impact-resistant; The smooth design of the train feels good to the touch and will not harm the child''s hands or body Richer Track Types For More Fun ：The Christmas train set only needs to assemble the railway into various shapes (circular, oval and luxury layouts), and each electric train track is locked firmly, then turn on the switch, the Christmas tree train set will move steadily on the toy track; DIY train sets for boys 4-7 can improve children''s hands-on and thinking skills; If parents accompany their kids to assemble this electric train together, it can also strengthen the parent-child relationship Perfect Christmas Toys Gifts For Kids ：The perfect train set for Christmas tree with Xmas elements puzzle, suit for decoration under the Christmas tree, and let children and family spend a wonderful Christmas time together; For every child, the toy train set is a fun and educational holiday, birthday and Christmas gift; The toy trains model are suitable for boys and girls over 3, 4, 5, 6, 7, 8 years old; Let your child get double the happiness from you', 'Small', '1.5 pounds', '{"full alloy steam trains","1 coal carriage","2 passenger carriages",lights,"8 curved tracks","8 straight tracks","4 Y-shape tracks","1 cross track","60 track locks","1000mAh (3.7V) rechargeable lithium battery","USB charging cable","lighting carriages"}');


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.reviews VALUES (2, 'Perfect to play with supervised with an adult. The kids really love it. I thought it might be a little slow for them, but nope, it gets their imaginations going. Put a tiny piece of paper on the track and say it''s a pretend penny. Make a cardboard tunnel. Lots of FUN. Battery powered runs for weeks. Just be sure it''s off or you will be buying batteries.');
INSERT INTO public.reviews VALUES (2, 'These larger-scale Lionel trains are perfect for our kiddos who play more on the rough side. This is the 4th ''version'' of those larger trains we purchased (we already have Polar Express, Diesel Construction, and Toy Story) and it did not disappoint. Great sounds, stays on the track, couplers keep train cars together. Couldn''t ask for more.');
INSERT INTO public.reviews VALUES (2, 'This is the 5th Lionel Ready to Play train set we have bought for our children. Great for young train lovers who are not ready for the more advanced sets. Fairly durable, all of our five sets are still running, despite abuse.');
INSERT INTO public.reviews VALUES (2, 'The instructions are sparse, but assembly and operation are pretty easy to figure out. The plastic construction has me concerned about durability, but other reviewers are not critical of this. Looks great and works well.');
INSERT INTO public.reviews VALUES (2, 'Excellent first train set. My child will be 3 in March and after one day has learned to operate it by himself. It''s not the same Lionel we grew up with, but for the price, it''s an excellent starter set.');
INSERT INTO public.reviews VALUES (2, 'I have actually bought two of these. The Polar Express for my own enjoyment around the Christmas Tree every year and this one, the Pennsylvania Flyer for my grandson. They stay on the track and little ones can operate them. The sounds from the engine and control are well received by children.');
INSERT INTO public.reviews VALUES (2, 'It''s ok, nothing great, it''s made out of cheap plastic, the tracks snap together. It doesn''t have the magic of trains from back in the day. This is a sellout product from Lionel in my opinion.');
INSERT INTO public.reviews VALUES (2, 'This thing was incredible. It managed to occupy not three, but FOUR toddlers for hours every day for a week as it chugged around the Christmas tree. Judging by the amount of trauma it went through at the hands of the kiddos, it seems pretty difficult to break. Worth every penny.');
INSERT INTO public.reviews VALUES (2, 'Use I saw USED but good! I was a little skeptical, however when my train came I would have never noticed it was used! Fantastic quality! My two year loves it!!! The remote controls speed of the train, the lights, the noises. Very impressed with this product!');
INSERT INTO public.reviews VALUES (2, 'My great-grandson will be 3 in July. I got him an electric train set and he broke one of the tracks and parts off of the train the first day. So I put it up and ordered this. I love this larger size. I can''t say how durable it is since we just got it today, but working fine.');
INSERT INTO public.reviews VALUES (2, 'Only used a few times at Christmas. My son recently brought the train out to play with it, and the remote won’t work. Changed batteries and everything. It seems the batteries are not being held in tight enough in remote to make proper contact.');
INSERT INTO public.reviews VALUES (2, 'The Locomotive did not move only the sound worked. The exchange process was real easy. I am hoping the next one that arrives works. I like this train model and the removable cargo and design. I was real disappointed when it did not arrive.');
INSERT INTO public.reviews VALUES (2, 'Easily put together. My 18 month old granddaughter loved it under the Christmas tree. it is very durable. Not cheaply made.');
INSERT INTO public.reviews VALUES (2, 'Great toy for under the tree. I had three problems with it, though. First, I received the box with impact damage at one corner. Luckily, the toy was not damaged. Second, the toy did not arrive with any instructions. Thirdly, the center detent on the remote forward/reverse throttle tends to wander.');
INSERT INTO public.reviews VALUES (2, 'It’s made very well, and makes all the right sounds. It was perfect for my toddler grandson. His eyes just lit up when I gave it to him.');
INSERT INTO public.reviews VALUES (2, 'This little train was just the perfect size to put under the Christmas tree. Every one from 7 to 77 loved it. Just wish we’d had it years ago. It was so easy to put together.');
INSERT INTO public.reviews VALUES (2, 'Not what we thought but still it''s very cool.');
INSERT INTO public.reviews VALUES (2, 'It was bigger than expected, such a joy to have this kind of quality toy for my toddler who loves trains. Enjoyment for many hours and easy to store until later.');
INSERT INTO public.reviews VALUES (3, 'Great Basic Trainset. We got this train set for my 2 1/2 year old and he’s obsessed with it. The steam coming from the smokestack looks amazing and it lasts a surprisingly long time for such a small amount of water...');
INSERT INTO public.reviews VALUES (3, 'Nice train set! This is a really nice train set, especially at the price point (I purchased for $40 USD)...');
INSERT INTO public.reviews VALUES (3, 'Well made. Track is easy to assemble, perfect for my Christmas train. Love the realistic sounds. Great bargain.');
INSERT INTO public.reviews VALUES (3, 'CHHOOOOOCHOOOOOO. Great start we set! I got the metal version, and I really liked it for the price...');
INSERT INTO public.reviews VALUES (3, 'Not the best train set. The price is obviously the selling point, which is also reflected on the product. Here are my issues with the train set...');
INSERT INTO public.reviews VALUES (3, 'My son loves it. Bought this for my son’s 3rd b’day. It’s such a fun toy. We put it together quickly...');
INSERT INTO public.reviews VALUES (3, 'Assembled with old ones. I did not expect 5 years old train set assembled with it. This one is large with 8 paths...');
INSERT INTO public.reviews VALUES (3, 'nice train. stable, ease use, nice product.');
INSERT INTO public.reviews VALUES (3, 'Kids will like it. Train set lookings amazing with steamer, it comes with remote control which can be used to steer wagon back and forth...');
INSERT INTO public.reviews VALUES (3, 'Great First Train Set for 4 Year Old. Title: Christmas Train Set...');
INSERT INTO public.reviews VALUES (3, 'Great. This is A good product, the pictures made it seem bigger then it is but I still like the train...');
INSERT INTO public.reviews VALUES (3, 'My kid likes this one. Only flaw is it consumes battery too fast. All the features are good: smoke, music.');
INSERT INTO public.reviews VALUES (3, 'A Train was all my grandson wanted for his Birthday. We got the train was awesome. The beauty is what I liked.');
INSERT INTO public.reviews VALUES (3, 'On/off power switch is poor. Otherwise, it works as expected. I had to replace the power switch after a few hours of my grandson playing with the train...');
INSERT INTO public.reviews VALUES (3, 'Great train. My toddler is enjoying his train. Not hard to put together for him.');
INSERT INTO public.reviews VALUES (3, 'Love it! I bought this train for my nephew''s birthday and he loves it! The steam is a nice touch that''s enjoyable...');
INSERT INTO public.reviews VALUES (3, 'It actually steams! Got this for our son. It’s a great size for his room and he loves that it actually steams.');
INSERT INTO public.reviews VALUES (3, 'Train set for a kid. Got this train set for my 9 year old son who loves trains. He loves the smoke being given off from the engine...');
INSERT INTO public.reviews VALUES (3, 'Nice train for older children. My 2 year old loves this train but there are very tiny pieces that attach the tracks that come off easily...');
INSERT INTO public.reviews VALUES (3, 'Bad quality. After 3 months it broke.');
INSERT INTO public.reviews VALUES (3, 'Cute train. My 4-year-old grandson loves this train but bored with it fairly quickly...');
INSERT INTO public.reviews VALUES (3, 'It''s so cute. I bought it and put it under the Christmas tree. It''s very cute, but it has its drawbacks...');
INSERT INTO public.reviews VALUES (3, 'You train. It was not very durable; it broke very easily.');
INSERT INTO public.reviews VALUES (3, 'Good! We liked this train a lot! Very cute and well built...');
INSERT INTO public.reviews VALUES (3, 'My grandson loved it! I love the steam and the sound. Just like a real train!:)');
INSERT INTO public.reviews VALUES (3, 'Pretty decent little train. This train is pretty great, has held up to toddlers for at least three days now...');
INSERT INTO public.reviews VALUES (3, 'Great for value. Great for value, but the image shows tracks crossing, and it does not come with enough pieces for that...');
INSERT INTO public.reviews VALUES (3, 'The train works extremely well! The train has realistic sounds and smoke. It stays on the track...');
INSERT INTO public.reviews VALUES (3, 'A great train set for young children. This is a terrific train set for my 4-year-old granddaughter...');
INSERT INTO public.reviews VALUES (1, 'The instructions were slightly lacking with expansion pack operation, but with the DC controller I figured out that turning to channel 10 then applying increased power is what will actually drive the track switches from the expansion track pack. I had to hook the switches in line before the main power connected to the track. Also, make sure all your loops only allow travel in one direction. If you try to connect a loop so the track runs backward onto itself, it seems like it will short circuit out and the trains won''t run. All the track pieces went together nice and smoothly, the trains both started on channel 3 correctly. It was super easy to switch them to channel 1 and 2. They ran at the same time flawlessly. There are lots of good YouTube videos to help with ideas for layouts. I''d recommend this for kids 6-9 with adult assistance, and over 9 just show them how to be careful with the track connectors then let the kids work out the kinks. Overall a decent value for the quality and price.');
INSERT INTO public.reviews VALUES (1, 'I love this DCC set. I have had it for 2 years. I have expanded my set on a 5 x 10 board to have 3 oval tracks connected by crossover tracks. I am running 4 trains at one time and it works great. One of my engines has sound and this works great too. I am using the original DCC controller that came with the set. I do not need the 5 amp add-on power that some reviewers think you may need. Bachmann makes quality products at a reasonable price.');
INSERT INTO public.reviews VALUES (1, 'I have had this starter DCC set for about 2 months and have given the locomotives frequent use. I bought the Bachman Track Pack and this track plan fills my 4x8 layout. I replaced the track pack''s 4 turnouts that are wired with DCC-powered turnouts. I have used 6 of the 10 EZ Commander DCC addresses with the 2 locos and 4 switches. Great fun. I am usually hard to please yet thus far I am pleased and this set introduced me to DCC HO gauge model railroading. All the accolades noted, would I repeat the purchase? I would not, and this is not from dissatisfaction with the set. It is from expanded knowledge of the hobby and realization that I would not want to expand the 4x8 layout with the Bachman all-in-one EZ Track. It is not as realistic as sectional track with a separate roadbed. You can put your own DCC layout together even if you are a beginner. Read and study. For about the same cost, you could go with a bit higher-end setup buying the components separately. Many options, but this could be one: Atlas HO sectional track with more than enough to fill a 4x8. Amazon has Atlas starter track packs. Maybe the Digitrax DCC starter components. A couple of the lower-priced Bachman DCC onboard locks like the ones that come with the Digital Commander will complete your start in model railroading. If you want to be thrifty and know you won’t eventually yearn for a room-filling railroad empire, go with the Bachman Commander and have fun! I plan to continue building my 4x8 layout and may even mate the EZ Track to higher-end sectional track with my next adjacent table. That''s a little funky, but I think it can be done with some thought and study. Hope my sharing here may be useful to some of you. Forgive the typos!');
INSERT INTO public.reviews VALUES (1, 'Once upon a time, I bought this train set as an introduction to DCC. That it did and it provided me with a year or so of enjoyment until I overloaded it. One way or another this set is a decent entry-level train set into DCC. Just beware of some possible manufacturing or storage errors. First off the set came packaged well, and despite a reckless UPS man it arrived at my front door with no damage. Upon setting the train set up on the floor and running the trains for a few hours, everything seemed well. So I packed it up again and took it to my layout, which was under construction. The DCC system as well as the track used in the set, were heavily used. Unfortunately, this is where the problem started. The F3, (red and silver locomotive) somehow managed to bend an axle. Sadly I didn''t know about the warranty program, and pitched it. A week or so later after a visit to a train show, my brand new 2-8-0 steam locomotive developed a valve gear problem. All the metal pieces that connect the wheels together got tangled up, and the train seized up and ground to a halt. After a little work, I managed to get the valve gear back the way it was supposed to be, only to find out the inner axles had twisted and broken. The culprit turned out to be the manual switch used in this set. The frog of the switch, the piece that rerails the train after it crosses over the points themselves, was warped just slightly and made itself a hint too narrow. This caused certain locomotives to bend their axles slightly, eventually leading to total failure. After replacing that switch, not a single locomotive has had a problem on my layout. I was lucky that only two engines suffered this fate, however, this being said, I doubt it was Bachmann''s fault. These train sets are designed to be sold at Hobby Stores, where there is climate control and AC, not the massive Amazon warehouses. Now, I''m not saying Amazon is totally at fault, but I am saying every train set I''ve bought from a local hobby store has been flawless, Bachmann or otherwise. And upon browsing the other train sets on amazon.com, I''ve noticed similar complaints. Trains not staying on the track, tracks not going together, derailment all the time, small pieces breaking off when taking out of the box, warped track, so on and so forth. Now my second train that I bought from Amazon has been flawless, I bought the Echo Valley Express as a replacement and it''s been a bundle of fun. So I have a feeling that buying train sets from amazon.com can end up being a mixed bag. I recommend checking your local hobby shops first and then compare prices. Amazon is normally lower, so it''s up to you whether the risk is worth the reward. As for the set itself, the blue and yellow diesel continues to be a hard worker on my layout. As I said I accidentally fried the first EZ command trying to get it to run a DC Loco that was nearly 40 years old. All the other track minus the switch is still in use. And the Rolling Stock is also perfectly adequate. Personally, if you want to see all the advantages of DCC I would pick this set up as long as you accept the fact it could be faulty. The value for money is well worth the risk, as long as you are insightful. Check your rolling stock after I would say 5 laps, check for extreme bumpiness when going over the switch, and listen to your models. Any buzzing, grinding, or any other noise out of the ordinary needs to be addressed. And should something go wrong remember that they have a lifetime warranty on all their equipment. Don''t be a fool like me and throw some trains out. Also, one last word of advice. The EZ command is designed for small layouts. It only has enough power to run 3 trains at once despite having the ability to program 10. If you''re buying this to upgrade an existing layout be aware of this. Bachman does offer a 5 amp power booster, and this would provide more than enough power to run any locomotive you want.');
INSERT INTO public.reviews VALUES (1, 'I loved model trains as a child so I was excited to get my young son his first electric set. The box says 14 & up but I remember playing much earlier. The DCC controller allows you to run multiple trains independently, something that took a lot of work in the old days, and this set includes two train engines which is quite a bargain, I think. Set up was easy and the included video made understanding the DCC controller so simple that my son figured out how to turn the engine lights on and off just by overhearing the TV while playing. The snap-together track isn''t perfect but it is pretty good and connecting the few wires is very simple and tool-less. Both engines pull the cars well and I have played with this set nearly as much as my son. The ability to add other engines including one analog train is very nice. In fact, we bought another set to go with this and have three engines going at once. My only complaint is with the rolling stock. The wheels fell off one of the cars right out of the box and it has been a tad problematic. We''ve only had it for a day so it''s hard to say how durable this is yet. Overall, I''m very pleased with this set and I would recommend it to anyone interested in a train set. Getting two DCC engines, track, and a DCC controller for this price is pretty good. I just wish they offered a greater variety of engines in their starter sets.');
INSERT INTO public.reviews VALUES (1, 'Had a great time setting it up and once it was all together the 6-year-old it was bought for was able to operate it with no problem. It did take him a while to master setting the trains on the tracks but it was not a problem as they cannot damage anything by attempting to master that skill (pretty much the hardest thing for the little guy to do). Straightforward controls once you read the instructions, you can set up several different engines on the switchboard they provide. It was bought for a Christmas gift and he is still playing with it regularly.');
INSERT INTO public.reviews VALUES (1, 'The first set I received had a faulty power pack but amazon replaced it almost before I could tell them about it. The second is set up and running. The appearance is a bit better than I would expect from toy quality set, a bit cheap looking but adequate. The speed control is very smooth both forward and reverse. The track went together easily and has not vibrated loose, at least not yet. I knew nothing about DCC before buying this set and found it very easy to understand. The instruction DVD is plain language and informative. This is a very good choice for a back room set. I do recommend it. Forgot to mention why I took a star away. The electric motors are very loud and make quite a whine. The couplers also do not match height from car to car, or car to locomotive. These are minor things, I know.');
INSERT INTO public.reviews VALUES (1, 'First let me say I am not a novice. I had quite a large system years ago (base of 2 ping pong tables, Two rail system with a turnout for a yard, accessories including electronic yard warnings, lighted passenger cars (which my wife and I installed), and others. I only got rid of this system because we moved and didn''t have the space. Therefore the following. Normally I would have given Bachmann a much higher review (4 *). However, their QC sucks. The controller I received does not match the one in the instructions. But I tried to work with it, anyway. What a pain. 1. No on off switch 2. Directional signals are up down instead of left and right (not a big deal, but worth mentioning). 3. The back of the controller in the instruction does not match the one I received. 4. No import for accessories 5. DSL port on the controller - not in instructions (I expect this is the connection for accessories. Then there''s the EZ tracks. They were sub-par. Some were difficult to put together (pin alignment etc.) I have been able to get both locomotives running on different buttons but not at the same time. It took quite a lot of trial and error to achieve both of them running at all. If you don''t have experience with model trains and a lot of patience you will be very disappointed. I guess I have run out of patience. I am hoping this review reaches Bachmann. If not I will send them a message.');
INSERT INTO public.reviews VALUES (1, 'From an appearance standpoint the trains look great. However, trains derail frequently; train to rail alignment is a challenge which is why the track to track connections are critical to trains remaining running. Side Note: the analog connection wire was missing when the Trains were delivered. I contacted the Company''s Customer Service team and their comment was ''Oh, that happens a lot. We will send you a replacement connector''. It never arrived. Also, the Train Controller Unit operates on the function 3 setting but defaults to function 1 anytime there is a derailment or train stoppage. If you are interested in more than appearance keep looking.');
INSERT INTO public.reviews VALUES (1, 'A real disappointment. Clever layout with two good-looking locomotives that just don’t perform with the digital control. Very inconsistent operation, buttons switch over randomly to a different function, trains constantly derail. Best to look elsewhere and skip the allure of twin locomotives.');
INSERT INTO public.reviews VALUES (1, 'Perfect for converting to digital.');
INSERT INTO public.reviews VALUES (1, 'Bought this for my 8-year-old for Christmas. The layout went together fine and the cars and engines seem to run well. Unfortunately, the command controller fried after about 30 minutes of use, I think because of a derailment. We sent it in, and it took a solid 6 weeks to get it fixed/replaced. Luckily, our hobby shop let me borrow a DCC controller until we got our replacement back. So, aside from the quality of the DCC controller, we really like the set.');
INSERT INTO public.reviews VALUES (1, 'Bought as my starter set into model railroading. The EZ track is very easy to put together and I had trains running in no time. The DCC command is easy to use but it never took long before I wanted to expand into a bigger layout. I started using Atlas track and flex track so eliminated the EZ track, then wanted a better DCC system so replaced the Bachmann one. The locomotives are very basic and lack detail and the DCC decoders are not great. One locomotive made terrible noises due to the decoder so I replaced them with NCE replacement decoders. The rolling stock is ok. This is a good set if you will stay with EZ track and the Bachmann DCC command, otherwise just buy the better components separately.');
INSERT INTO public.reviews VALUES (1, 'The train set was exactly what we needed. Being new to model trains, my son received a DCC sound equipped steam engine for Christmas as well as some Bachmann expansion track. The problem was his existing model train set was an Atlas and didn''t have a DCC controller. The Bachmann track is incompatible with Atlas and he couldn''t use all the functionality of the new engine. So, we decided to switch him from Atlas to Bachman and we found that this train set was the best way to get into Bachmann and a digital command controller. It was available at a great price and works great.');
INSERT INTO public.reviews VALUES (1, 'Just follow the instructions on setting up the DCC for the engines. I have the F unit facing backward going forward with the GPU unit. I also bought more track to make the set longer to add more cars.');
INSERT INTO public.reviews VALUES (1, 'Not even close to worth the price. The lights on both locomotives didn''t work. There is no on-off switch on the power source, so it has to be unplugged. Derailed easily. One car wouldn''t couple. Returned and ordered a Lionel. We''ll see how that goes. Lionel Superchief was the way to go. Very happy with it.');
INSERT INTO public.reviews VALUES (1, 'When I opened the box, it looked like it was returned from someone else before. All parts were loose even when the wraps were there, one of the figures came broke. Nothing without repair with a little glue. Bad shipping, good product.');
INSERT INTO public.reviews VALUES (1, 'The track is hard to stay connected. The command control was defective. Had to send it back to Bachmann. Not a happy puppy.');
INSERT INTO public.reviews VALUES (1, 'Excellent product, fast delivery.');
INSERT INTO public.reviews VALUES (1, 'Got me started in a hurry. Good quality and value.');
INSERT INTO public.reviews VALUES (1, 'My only concern for not giving a 5-star rating was that the instructions for a novice weren''t very clear or helpful. I had to do a lot of research on the web to figure out how to hook things up. Otherwise, a great value.');
INSERT INTO public.reviews VALUES (1, 'This train set was a perfect purchase for our nine-year-old grandchild. It is easy to set up, easy to run, and the DCC enables the train set to easily add extra tracks and boxcars.');
INSERT INTO public.reviews VALUES (1, 'We purchased this set as a gift for our 9-year-old son. One of the trains was broken right out of the box. I considered returning the whole thing to Amazon, but since one train did work, we decided to keep it and just return the one broken train to Bachmann. What a mistake! Bachmann says it will take 6 weeks to replace the train. 6 weeks to replace something that was broken right out of the box. THIS IS UNACCEPTABLE! Bachmann should immediately replace the defective train. I should have sent the whole thing back to Amazon for a full refund. No Bachmann trains this Xmas - their Customer Service is terrible.');
INSERT INTO public.reviews VALUES (1, 'Being as this set enables you to run more trains at once, it makes for a much more interesting hobby and is a more realistic setup. Had to get our son to do the programming though, as this is not my strong point. This has made an old man very happy, highly recommended.');
INSERT INTO public.reviews VALUES (1, 'I bought this set in the hopes to someday be able to get into trains a little more and that maybe my son will enjoy them with me. Very affordable and easy to use. Again, nothing more than a starter kit.');


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 3, true);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

