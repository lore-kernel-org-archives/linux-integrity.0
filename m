Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E790C433E0
	for <linux-integrity@archiver.kernel.org>; Sat, 30 Jan 2021 21:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE28D64E11
	for <linux-integrity@archiver.kernel.org>; Sat, 30 Jan 2021 21:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhA3VPU (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 30 Jan 2021 16:15:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:54632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230036AbhA3VPT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 30 Jan 2021 16:15:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B713864DE4;
        Sat, 30 Jan 2021 21:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612041279;
        bh=H3Jm+cFVvLLUvGvLepRUBygWjfm1QjCsaCYM3g6rqSE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ew+HK7lY9OTnJQQmn1YCp79VzMNdM+PpTs5I6jwxHUaasZ353Aefef7yP8gyYEAot
         qYF2SPWC9CbV9pIzOiN6WkeXpqjGTyD8T4AvEKJ1+nWyk892NV0cBZsMbsCP+TBIhj
         MKMHWh7fT+R0lXJU+Mn3GayDW4cLbzSNt1Z2LEMusqZKoDi728OBCwBSSlDpUruGuU
         CpNSBxpTO/eelhKb70hSuB1s6LzQuVeF+z5ZqsCDNcQyDt8MGH5KDTzq8Bumuy8Nh5
         l2pSULkm56a7FfCIYdPGAJZ5n6sKscQz2GP4aW+Rmmu+UZYN+qUVYCqXB7lDj/wW6m
         SmXM0S5wcsDEw==
Message-ID: <4718c02f91c24085cf0c94290af628c5bc51beab.camel@kernel.org>
Subject: Re: [PATCH v2] tpm: ibmvtpm: fix error return code in
 tpm_ibmvtpm_probe()
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wang Hai <wanghai38@huawei.com>
Date:   Sat, 30 Jan 2021 23:14:34 +0200
In-Reply-To: <262c3095-d4c0-f124-c8bc-e99685cbe572@linux.ibm.com>
References: <20210126014753.340299-1-stefanb@linux.vnet.ibm.com>
         <YBRHfZeqAirQolIN@kernel.org>
         <262c3095-d4c0-f124-c8bc-e99685cbe572@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-01-29 at 13:57 -0500, Stefan Berger wrote:
> On 1/29/21 12:35 PM, Jarkko Sakkinen wrote:
> > On Mon, Jan 25, 2021 at 08:47:53PM -0500, Stefan Berger wrote:
> > > From: Stefan Berger <stefanb@linux.ibm.com>
> > >=20
> > > Return error code -ETIMEDOUT rather than '0' when waiting for the
> > > rtce_buf to be set has timed out.
> > >=20
> > > Fixes: d8d74ea3c002 ("tpm: ibmvtpm: Wait for buffer to be set before =
proceeding")
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Signed-off-by: Wang Hai <wanghai38@huawei.com>
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > ---
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> >=20
> > Thanks! Should I add
> >=20
> > Cc: stable@vger.kernel.org=C2=A0to this?
>=20
> Yes, that would be good! Thank you!


OK, it's applied.


> =C2=A0=C2=A0=C2=A0 Stefan

/Jarkko
