Return-Path: <SRS0=Ztmh=XF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA02EC3A5A2
	for <linux-integrity@archiver.kernel.org>; Tue, 10 Sep 2019 12:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D16D2084D
	for <linux-integrity@archiver.kernel.org>; Tue, 10 Sep 2019 12:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EDXAKCf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbfIJMcS (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 10 Sep 2019 08:32:18 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:42969 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730574AbfIJMcS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Sep 2019 08:32:18 -0400
Received: by mail-lj1-f180.google.com with SMTP id y23so16215549lje.9
        for <linux-integrity@vger.kernel.org>; Tue, 10 Sep 2019 05:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rslsOmNRpBHkMMFNJES6CmbCqWGl1Ryh8tluAzHuGe0=;
        b=EDXAKCf7ts9Ljoi1r0svascmeNbHbBbaJY+hzhLWFe6JMbQX6rzmpQLHeEwnqxJtZN
         j2VvSW4RwqL7A0MO/wcdUSQ3ogveHMpYsO7u4vKAvvqlnQd6jaqusosndHZf06kTevD0
         c/FbAMadwG5rDr77mQdzoGe6PDu8gmwmGdJaR/JttStJZaA3XRLWOMCClVEB4T8LeMWp
         AzQipC+QGNkwN9eHrt/bDsIDr/2wKE++ey8BMIJQqr3h900w76BlvoHTPmUdd62WIeeD
         qNa96n8zwMWGs6RphDilklFMPSWaEaVJvr+PZiDnr92We+tt7Z1v/akyBcbxkRyCviey
         dNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rslsOmNRpBHkMMFNJES6CmbCqWGl1Ryh8tluAzHuGe0=;
        b=UKycpEqyFO32hWcVdC0vEcCH6VyIJEavgqk5SU9qr7h3T6+6OHeX/vC5zFmx9PuK5X
         eOnhtWtopw8B3Ilu+EmuabRISPsIiujUZBSxc42p3ZeER5+ss2Eg5XS4iaemPxnVVKjj
         2aeRq/AhoLD/SWWy8eEvaJSzQ/uIbTGixGs/YdMIS0ESc4v7iYIhkV5D+tOSbmx9pUqR
         0QD+M35eYdxFWYt1GYcgxXJ8NFMy6WwUGyCnS89nHf+scw05ssPDxmWC4fo3FB8uz2nB
         D+gqPFBym9gb+Zoq65c5JXYpxjm6p3cOkrlpfF0z6W84Xnj5ZSujHpTQ6wwPr62NslpI
         1TDg==
X-Gm-Message-State: APjAAAVZzz6j8JV9bbTQpqbyu0EV97S+I+3IRC7s1RGIbRjIbBV0Vveu
        /vUbCYhng1niPnhvyav9rE1PsuToRgvc5nb2RM4L6v3H
X-Google-Smtp-Source: APXvYqyu6r6VnacW1vJUw/jr9G7sqjNrHydA+MUqijxGp6KKeFb8i7wnJGz/9RRyhgxaCCLlX7TMXRSpiY7uiQ3kV0Y=
X-Received: by 2002:a2e:380d:: with SMTP id f13mr1970115lja.142.1568118735823;
 Tue, 10 Sep 2019 05:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <c253ca7292b397f1352d2ee00fce0b011f84abff.camel@linux.intel.com>
 <1567952431.4614.140.camel@linux.ibm.com> <CAFA6WYPq8Tq6=jTqnWQf9w9pzdJu8AcX-CFBWPwoVmMaLEJKhg@mail.gmail.com>
 <20190910114336.GA7018@linux.intel.com>
In-Reply-To: <20190910114336.GA7018@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 10 Sep 2019 18:02:04 +0530
Message-ID: <CAFA6WYNnCC96K8-4U9pDh3Ro402FQzy66LGeqVc5S9ucQCJDaA@mail.gmail.com>
Subject: Re: KEYS-TRUSTED git
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        jejb@linux.ibm.com, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 10 Sep 2019 at 17:13, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, Sep 09, 2019 at 11:57:45AM +0530, Sumit Garg wrote:
> > @Jarkko: No worries, I understand the situation.
>
> I made the call to add them anyway to my TPM tree.

Thanks.

-Sumit

>
> /Jarkko
