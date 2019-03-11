Return-Path: <SRS0=7u+B=RO=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7FDC43381
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Mar 2019 00:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B8520652
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Mar 2019 00:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfCKAEy (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 10 Mar 2019 20:04:54 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:33384 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfCKAEy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Mar 2019 20:04:54 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id F24FD72CC61;
        Mon, 11 Mar 2019 03:04:50 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id C40DC4A4AF6;
        Mon, 11 Mar 2019 03:04:50 +0300 (MSK)
Date:   Mon, 11 Mar 2019 03:04:50 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] ima-evm-utils: simplify digest alias handling
Message-ID: <20190311000450.ijp7klkcc2sggbka@altlinux.org>
References: <20190212224631.13398-1-vt@altlinux.org>
 <1552256785.6100.4.camel@linux.ibm.com>
 <20190310230824.wjx6x3c5ddqjj4su@altlinux.org>
 <1552260459.6100.21.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1552260459.6100.21.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Sun, Mar 10, 2019 at 07:27:39PM -0400, Mimi Zohar wrote:
> On Mon, 2019-03-11 at 02:08 +0300, Vitaly Chikunov wrote:
> > On Sun, Mar 10, 2019 at 06:26:25PM -0400, Mimi Zohar wrote:
> > > Hi Vitaly,
> > > 
> > > On Wed, 2019-02-13 at 01:46 +0300, Vitaly Chikunov wrote:
> > > > - Make digest name search work just with simple strcmp() and three
> > > >   arrays, dropping strmatch().
> > > > - Remove get_digestbyname() which was doing two hash name resolving
> > > >   attempts, reverting to use plain EVP_get_digestbyname(). This will
> > > >   force the user to specify the proper hash name depending on what
> > > >   OpenSSL provides, allowing to specify older hash name in older
> > > >   OpenSSL.
> > > > - Improve hash_info parser to produce hash_algo_name[] more resembling
> > > >   what is in the kernel, making algocmp() not needed and removed.
> > > > - Fix indent in get_hash_algo_by_id().
> > > 
> > > Thanks, this is a lot better. šAs there isn't a "Signed-off-by", did
> > 
> > Forgot this. I can resend with "Signed-off-by".
> > 
> > > you want to squash this with the original patch - "Extract digest
> > > algorithms from hash_info.h"?
> > 
> > Do you mean rebase squash with already upstreamed commit? Did not know
> > this is allowed.
> 
> Agreed, normally it shouldn't be done, but it hasn't been included in
> a release. šDefining and then removing algocmp() doesn't make sense.
> 
> > 
> > If you want to do it, this probably should not be squashed with "Extract
> > digest algorithms from hash_info.h", but with "Try to load digest by its
> > alias", because it is simplification of this commit.
> 
> Unless there is a reason for keeping these patches separate, please
> squash them. šIt will be easier for anyone reviewing the code.

I will rework two top commits:

  0267fa1 (master) ima-evm-utils: Try to load digest by its alias
  942d9f9 ima-evm-utils: Extract digest algorithms from hash_info.h
  07d799c ima-evm-utils: Preload OpenSSL engine via '--engine' option
  7e2a784 ima-evm-utils: Allow using Streebog hash function
  b853b7b ima-evm-utils: Define the '--xattr-user' option for testing
  1d9c279 ima-evm-utils: Define hash and sig buffer sizes and add asserts
  9643544 ima-evm-utils: Fix hash buffer overflow in verify_evm and hmac_evm
  1541069 ima-evm-utils: libimaevm: get key description out of verbose condition
  8c8f29e (origin/master) ima-evm-utils: check the return code from tpm_pcr_read() in ima_measurement()

Into two new commits over (07d799c):

  "Extract digest algorithms from hash_info.h" - remove algocmp()
  "Try to load digest by its alias" - squash with "simplify digest alias handling" patch.

> 
> Thanks!
