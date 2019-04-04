Return-Path: <SRS0=GWgT=SG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8993C4360F
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Apr 2019 21:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A210020882
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Apr 2019 21:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QeLByr0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbfDDVqX (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:46:23 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36612 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfDDVqX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Apr 2019 17:46:23 -0400
Received: by mail-it1-f193.google.com with SMTP id y10so6296958itc.1
        for <linux-integrity@vger.kernel.org>; Thu, 04 Apr 2019 14:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rp1GtoMgq/0SPfk50ZwTWjmKuGn40Qqvv29qBcLQKFs=;
        b=QeLByr0gd8cUfQco8vzbQzH6tmppj+6T84uZIcNyimmRuQSr8Zjnv5bk+VXbvjVe+F
         g0RhEM0jmXGDqRjhdXQE8CuxTCTkpigQQV7a8fHWiHoIuTXlPcva6ulOFuBib2GJqRre
         Ny69R43x8OqPG0qLETRrjov7hNj9gJ9wJ8VCHYq7lYIKaPSM5OsoXYU9E4nknQaWdeja
         vvDLgHzSwdA8/wgxe/dl7fX1cdhsXtg/XT6kbBUeqF0kalhBHSDzT0lBRglCCrcBxzWW
         hxM0Iq5acpeM/6EtE3hh6cgcivVk59hI1l0hF/+orPi4La2C1xnKMxS5lm51qr9lJK8e
         J2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rp1GtoMgq/0SPfk50ZwTWjmKuGn40Qqvv29qBcLQKFs=;
        b=RrAeAZUFFKJRPLnmaQVXGDxqtZc8CkJVnaIBM6gN2/moRVeCz+tBwRU/URowj9/uTN
         FNFYd05deDPuDIPxK0fa1zk1ux2XialhIDgwIktr6pfys6VIQEA/n8Nt6f+S92W+/MFq
         HYTC2UzEotk06ipaUr7NNN2QzUYsNRp7azQvydGs/OZiXtLg8R9qjS4cN53+8LuxsiTg
         gK5+vTFgOaPXg3MkH1ZaRGdKV5oCcn3dX9ulcvn1IRoDaR3WtyAfhWzt55i1aw3qJ3fu
         P5uhdmFnmut3Jw2TIfmbsjv0BfZ69R4H/TVdLo0BSgm608UJ/4cexdDzoF8Rzm8fi6w4
         1adQ==
X-Gm-Message-State: APjAAAUhDKovbsgMt+CwXbrEZKP91crwzTprt0IfWe9VqW/99sUmhvLx
        3qeeSEehVWaApPPqGBIrUlm9cz3RIBucwH2gMVI/BQ==
X-Google-Smtp-Source: APXvYqxbSmiQQk7DWc6odzOA0qvLXOCOiZApEGOlfdFwat4Q6+pt9W+9NGHMNdM98Eo4937Lf1cEWn029/bykcdGGBw=
X-Received: by 2002:a02:c50b:: with SMTP id s11mr7061763jam.84.1554414382363;
 Thu, 04 Apr 2019 14:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190226215034.68772-1-matthewgarrett@google.com>
 <20190226215034.68772-4-matthewgarrett@google.com> <1551369834.10911.195.camel@linux.ibm.com>
 <1551377110.10911.202.camel@linux.ibm.com> <CACdnJutfCxzQDeFzXmZ9f8UrnqNScErkBJd2Yu+VEoy4nBhBCA@mail.gmail.com>
 <1551391154.10911.210.camel@linux.ibm.com> <CACdnJuuRLDj+6OTohfTVzqXp1K7U3efVXXuFfBfhk3CiUBEMiQ@mail.gmail.com>
 <CACdnJutPWEtDMS6YUXF0ykq7gKgQRNk6Fw=aHivHz6+NTodsgA@mail.gmail.com>
 <1551731553.10911.510.camel@linux.ibm.com> <CACdnJutWRB1up6wO3aWJJah3p8k+FY6xEfjw8ETHT69Vvsz8GQ@mail.gmail.com>
 <1551791930.31706.41.camel@linux.ibm.com> <CACdnJuvfzvZaU3CHtvVAP6vj_-rnWeTyAKjmRj8QGt7WAmjicQ@mail.gmail.com>
 <1551815469.31706.132.camel@linux.ibm.com> <CACdnJuvhu2iepghLm4-w2XVKH+TVT1JAY=vtKtf733UXPSBPaA@mail.gmail.com>
 <1551875418.31706.158.camel@linux.ibm.com> <CACdnJuvRuagNTidkq3d4g_OwfzqcALtd=g1-5LDzr2aBA1zV6w@mail.gmail.com>
 <1551911937.31706.217.camel@linux.ibm.com> <CACdnJut9T0xE-Q+ZAfqaRMUeBX=7w+cYE5Y7Ls1PdH-bJfv8MQ@mail.gmail.com>
 <1551923650.31706.258.camel@linux.ibm.com> <CACdnJuv+d2qEc+vQosmDOzdu57Jjpjq9-CZEy8epz0ob5mptsA@mail.gmail.com>
 <1551991690.31706.416.camel@linux.ibm.com> <CACdnJuvkA6M_fu3+BARH2AMHksTXbvWmRyK9ZaxcH-xZMq4G2g@mail.gmail.com>
In-Reply-To: <CACdnJuvkA6M_fu3+BARH2AMHksTXbvWmRyK9ZaxcH-xZMq4G2g@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 4 Apr 2019 14:46:11 -0700
Message-ID: <CACdnJuv2zV1OnbVaHqkB2UU=dAEzzffajAFg_xsgXRMvuZ5fTw@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] IMA: Optionally make use of filesystem-provided hashes
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 7, 2019 at 2:41 PM Matthew Garrett <mjg59@google.com> wrote:
> Yup, happy to get further feedback on this.

Anyone other than me and Mimi with thoughts here? :)
