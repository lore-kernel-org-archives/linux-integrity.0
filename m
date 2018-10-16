Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:57508 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726978AbeJPQCl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Oct 2018 12:02:41 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: 'Nick Desaulniers' <ndesaulniers@google.com>
CC: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Eric Biggers" <ebiggers@google.com>,
        "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] KEYS: trusted: fix -Wvarags warning
Date: Tue, 16 Oct 2018 08:13:25 +0000
Message-ID: <0147a993d4a94426afa469a8dcc4e5d7@AcuMS.aculab.com>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com>
 <20181011203126.15338-1-ndesaulniers@google.com>
 <0180360cfcb5458d8ff099744e8884d4@AcuMS.aculab.com>
 <CAKwvOdmXVY1iA-VAs-Ns3qVVnMTeU6v4RqxoS2=SJcSeQ23_og@mail.gmail.com>
In-Reply-To: <CAKwvOdmXVY1iA-VAs-Ns3qVVnMTeU6v4RqxoS2=SJcSeQ23_og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Nick Desaulniers
> Sent: 15 October 2018 22:54
> On Mon, Oct 15, 2018 at 2:26 AM David Laight <David.Laight@aculab.com> wrote:
> >
> > From: ndesaulniers@google.com
> > > Sent: 11 October 2018 21:31
> > ...
> > > by swapping h2 and h3.
> > >
> > > security/keys/trusted.c:146:17: warning: passing an object that
> > > undergoes default
> > >       argument promotion to 'va_start' has undefined behavior [-Wvarargs]
> > >         va_start(argp, h3);
> > >                        ^
> > > security/keys/trusted.c:126:37: note: parameter of type 'unsigned
> > > char' is declared here
> > > unsigned char *h2, unsigned char h3, ...)
> > >                                ^
> > > Specifically, it seems that both the C90 (4.8.1.1) and C11 (7.16.1.4)
> > > standards explicitly call this out as undefined behavior:
> >
> > I guess that problems arise when all the arguments are stacked
> > and va_start/va_arg use naive pointer manipulation.
> > In that case &h3 might be 4n+3 aligned so va_arg() will access
> > misaligned stack locations.
> >
> > I doubt any modern compilers (where va_start and va_arg are builtins)
> > will get this 'wrong' even when all arguments are stacked.
> >
> > Seems clang is being over cautious.
> 
> Yes; did you have feedback on the Denis' proposed fix, or another?

Personally I'd avoid char, short and bool for both function
arguments and results since they typically require extra
instructions for masking values (etc).
bool is particularly obnoxious.

In that case either int or unsigned int is good.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
