Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06D9C2B9F4
	for <linux-integrity@archiver.kernel.org>; Sat, 26 Jun 2021 00:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D16E61969
	for <linux-integrity@archiver.kernel.org>; Sat, 26 Jun 2021 00:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhFZA36 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 25 Jun 2021 20:29:58 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:44140 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhFZA34 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Jun 2021 20:29:56 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 421C872C8B4;
        Sat, 26 Jun 2021 03:27:34 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 2E8674A46EC;
        Sat, 26 Jun 2021 03:27:34 +0300 (MSK)
Date:   Sat, 26 Jun 2021 03:27:34 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v6 2/3] ima-evm-utils: Allow manual setting keyid from a
 cert file
Message-ID: <20210626002734.ojk57twxcnfnpzxw@altlinux.org>
References: <20210511115630.795208-1-vt@altlinux.org>
 <20210511115630.795208-3-vt@altlinux.org>
 <ffac9c53bacfc5a0d16ae457289d7c224c8ef924.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <ffac9c53bacfc5a0d16ae457289d7c224c8ef924.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 25, 2021 at 08:22:06AM -0400, Mimi Zohar wrote:
> On Tue, 2021-05-11 at 14:56 +0300, Vitaly Chikunov wrote:
> > 
> > +/**
> > + * imaevm_read_keyid() - Read 32-bit keyid from the cert file.
> > + * @certfile:	File possibly containing certificate in DER/PEM format.
> > + *
> > + * Try to read keyid from Subject Key Identifier (SKID) of certificate.
> > + * Autodetect if cert is in PEM or DER encoding.
> > + *
> > + * Return: 0 on error;
> > + *         32-bit keyid as unsigned integer in host order.
> > + */
> > +uint32_t imaevm_read_keyid(const char *certfile)
> > +{
> > +	uint32_t keyid_raw = 0;
> > +
> > +	__read_keyid(&keyid_raw, certfile, KEYID_FILE_UNK_CERT);
> > +	return ntohl(keyid_raw);
> 
> On error, __read_keyid() returns < 0, but the return value isn't
> checked before calling ntohl.

It does not need to be checked, because it also does not change value
pointed by `&keyid_raw' (which is 0 by default). Yes, this is not
mentioned in the `__read_keyid' description. But, otherwise (to change
pointed value on error) would be a bug.

> In either case, is imaevm_params.keyid
> suppose to be big endian byte order? 

No, it's in native order. This looked reasonable, since it could be
presented to the user as a hex number.

Thanks,

> If so, the call to htonl in
> sign_hash_v2() would be unnecessary.
> 
> thanks,
> 
> Mimi
