Return-Path: <SRS0=WCvd=A7=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AA1C433E0
	for <linux-integrity@archiver.kernel.org>; Mon, 20 Jul 2020 15:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 951B822C9D
	for <linux-integrity@archiver.kernel.org>; Mon, 20 Jul 2020 15:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259251;
	bh=nLwxoIlN783R9Fo19IjMWj9CH391cj+TIRpYLnLTxNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BIg2pzfApbYM9sv0HTcKE0jpnMekFU7Eetk1bdcwnwBSWcpX2oKWjr5mpWIpt+5WU
	 wVADzV3M1qTqBbqBt+jMNsES1dEi20fuKKIE6kIqaTQ7aGoNKLV1BQg4xtSp8wdWuo
	 ATfxOhSYrjspn7ZDx1t88HexHc4ev3XAtQfgvbpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgGTPeL (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:34:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgGTPeL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 11:34:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F11D22482;
        Mon, 20 Jul 2020 15:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259250;
        bh=nLwxoIlN783R9Fo19IjMWj9CH391cj+TIRpYLnLTxNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cqz5JRdnhyb3jPzhFKGOsCod8cxLMaGqEO36AyPT+HW1HD2GwQBOCKkLBVUwSGDcg
         qvp88ivbEBOmSbAAhAHxMVDPTMd1X4xRZ61x45j2bs2dNLRstbeiugEFS5P5fPNaaU
         OL0M9CCrP1Q34hmaMM0hawutLd0IMAOIH3W50UVw=
Date:   Mon, 20 Jul 2020 17:32:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prakhar Srivastava <prsriva@linux.microsoft.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, robh+dt@kernel.org, frowand.list@gmail.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, masahiroy@kernel.org, james.morse@arm.com,
        bhsharma@redhat.com, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        nramas@linux.microsoft.com, tusharsu@linux.microsoft.com,
        balajib@linux.microsoft.com, bauerman@linux.ibm.com,
        robh@kernel.org
Subject: Re: [PATCH V3 2/6] Update remove_ima_buffer code to use functions
 from libfdt reducing wrappers functions.
Message-ID: <20200720153202.GA1481119@kroah.com>
References: <20200720152342.337990-1-prsriva@linux.microsoft.com>
 <20200720152342.337990-3-prsriva@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720152342.337990-3-prsriva@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 20, 2020 at 08:23:38AM -0700, Prakhar Srivastava wrote:
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>

I know I refuse patches without any changelog texts, perhaps other
maintainers are more lax...

ALso, your subject lines are really odd, look at how almost all other
patches do it, we have hundreds of thousands of examples to choose from
:)

thanks,

greg k-h
