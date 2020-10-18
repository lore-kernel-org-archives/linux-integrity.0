Return-Path: <SRS0=zuG1=DZ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFEEC433E7
	for <linux-integrity@archiver.kernel.org>; Sun, 18 Oct 2020 21:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B058D22280
	for <linux-integrity@archiver.kernel.org>; Sun, 18 Oct 2020 21:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603055143;
	bh=BRpAzeVmAiwonfBXoWJUAJa6cC+Wi6yHfH8JcBIvdYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hkit0+wCk87yX3ZlPlOrxDtNstkh269m70VXq0Y0rwm0HMeQjfrc7aMA5acAUZqtx
	 KzSSeATDQU6rEtD2EvhnLZ7+C4Ua5llRFwN8M4h6tHRP5U0PyODuVyJ6vlB5es4H7l
	 ayzZwuLpJORrMeD0JvVrC7VPU5lljUugwGOu6iLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgJRVFn (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 18 Oct 2020 17:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgJRVFm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 18 Oct 2020 17:05:42 -0400
Received: from localhost (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA88F22245;
        Sun, 18 Oct 2020 21:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603055142;
        bh=BRpAzeVmAiwonfBXoWJUAJa6cC+Wi6yHfH8JcBIvdYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ofIXRkASRkohjfDIw4fHAB+xgigywccjoZAAGEVEkC148C76ho+ZLcSXCqDwIFyUa
         yx8wtB/NU2z99hYiZMLp5zLvR5169R43LYsk5xXgKbFobPAIvfg9nrgOuGZHl7x7au
         BiZoQZz47jhPPslo6rbR1WI11hhHrZ6DEsek0t38=
Date:   Mon, 19 Oct 2020 00:05:39 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     equired@linux.intel.com,
        justmentioningitbecauseIthinkthatwouldbeagood@linux.intel.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Borislav Petkov <bp@alien8.de>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v2 0/5] tpm_tis: fix interrupts (again)
Message-ID: <20201018210539.GA575510@kapsi.fi>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201013011745.GA41176@linux.intel.com>
 <87tuuyf97r.fsf@jsnitsel.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuuyf97r.fsf@jsnitsel.users.ipa.redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 13, 2020 at 08:15:36AM -0700, Jerry Snitselaar wrote:
> 
> Jarkko Sakkinen @ 2020-10-12 18:17 MST:
> 
> > On Thu, Oct 01, 2020 at 11:09:20AM -0700, James Bottomley wrote:
> >> The current state of the TIS TPM is that interrupts have been globally
> >> disabled by various changes.  The problems we got reported the last
> >> time they were enabled was interrupt storms.  With my own TIS TPM,
> >> I've found that this is caused because my TPM doesn't do legacy
> >> cycles, The TIS spec (chapter 6.1 "Locality Usage Per Register")
> >> requires any TIS TPM without legacy cycles not to act on any write to
> >> an interrupt register unless the locality is enabled.  This means if
> >> an interrupt fires after we relinquish the locality, the TPM_EOI in
> >> the interrupt routine is ineffective meaning the same interrupt
> >> triggers over and over again.  This problem also means we can have
> >> trouble setting up interrupts on TIS TPMs because the current init
> >> code does the setup before the locality is claimed for the first time.
> >> 
> >> James
> >
> > You should consider expanding the audience. Jerry, once you have some
> > bandwidth (no rush, does not land before rc2), it would be great that if
> > you could try this. I'm emphasizing this just because of the
> > intersection. I think it would also make senset to get tested-by from
> > Nayna.
> 
> I will run some tests on some other systems I have access to. As noted
> in the other email I did a quick test with a t490s with an older bios
> that exhibits the problem originally reported when Stefan's patch
> enabled interrupts.

Thank you. As said, I can make a pull request to rc2 or even rc3, if
needed.

/Jarkko
