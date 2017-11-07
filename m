Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:46197 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753273AbdKGQEG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Nov 2017 11:04:06 -0500
Received: by mail-it0-f53.google.com with SMTP id f187so3035849itb.1
        for <linux-integrity@vger.kernel.org>; Tue, 07 Nov 2017 08:04:06 -0800 (PST)
Date: Tue, 7 Nov 2017 09:04:04 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:INTEGRITY MEASUREMENT ARCHITECTURE (IMA)"
        <linux-security-module@vger.kernel.org>,
        "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
        <linux-crypto@vger.kernel.org>,
        James Morris <james.l.morris@oracle.com>,
        Matt Mackall <mpm@selenic.com>,
        David Safford <safford@us.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v2] tpm: Move Linux RNG connection to hwrng
Message-ID: <20171107160404.GG21466@ziepe.ca>
References: <20171031200503.GC18578@ziepe.ca>
 <20171105110506.usxmuzrvcjvxahr6@linux.intel.com>
 <20171106022704.GD26011@ziepe.ca>
 <CANc+2y6dx_2zOzFA5aFs7RpEV8aNqxpDghmx+q_+XyendYJoew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANc+2y6dx_2zOzFA5aFs7RpEV8aNqxpDghmx+q_+XyendYJoew@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Nov 07, 2017 at 08:50:44AM +0530, PrasannaKumar Muralidharan wrote:

> I am assuming you are talking about the following patches - using
> struct tpm_chip instead of chip number and this patch.

yes

> I won't be able to test if struct tpm_chip usage as I don't have
> multiple tpm hw in one machine. In case of tpm rng changes I can test
> only the lifecycle of tpm rng device. Is that enough? I feel my test
> will be limited. Please provide your thoughts on this.

That is certainly better than no testing.

Jason
