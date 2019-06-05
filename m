Return-Path: <SRS0=GZRA=UE=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5A2C28CC5
	for <linux-integrity@archiver.kernel.org>; Wed,  5 Jun 2019 18:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99D820866
	for <linux-integrity@archiver.kernel.org>; Wed,  5 Jun 2019 18:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mIHqWHmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfFESNF (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 5 Jun 2019 14:13:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39865 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfFESNF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jun 2019 14:13:05 -0400
Received: by mail-io1-f67.google.com with SMTP id r185so20964787iod.6
        for <linux-integrity@vger.kernel.org>; Wed, 05 Jun 2019 11:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2yqNv1T0KLqyhGhfx3cgDyPbVFkWsqnjKGUe5cPQeaM=;
        b=mIHqWHmRK3gkeOpjChRMdYtQ1WcIVhmcBmly4Ib+W2qj6/ehk/JJueJdstx95Qinnq
         gTEEaToPT/wrn6TYXPn5N60S8OOZOmpgYvamOzPMCoFqFps2HryiVrVMAPiLMiLS8RW+
         CdqFEZP3o+491Y7OA70y3YYRm5vGhkszdVaTrPx6MNcvxSflDEtVYT0u6MLAtpnZhRBe
         w18cLLb7cCLjna0kp1Jdr7tCboFsE6uBKCCLXnM4Y5x51VcOizVHDv4EzPVfrbfwbHZr
         kWBrRBd+PUlw0cAnqRXIXN6a73dyWFHAmbCUPmCBeFQ/qVRGz5YJxUvgUp/u3Kq3cg7V
         4gsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2yqNv1T0KLqyhGhfx3cgDyPbVFkWsqnjKGUe5cPQeaM=;
        b=PtYatzrlWYhl9MTH33BC3AW3jhVN2Ycrbl3laZJWy86sDny4QlevEEbv8EVAhlEyZR
         Z6KXxSM0aypBIVmyz/2zfy9JN9YJ0dIyHv/mlPGSmKfVQE63Z0otS+IiFfqgjmW6MqRw
         8qtJQ+jOvOkppiceF07Hc2ZExfRx3P3XWX7FLGTDteNUwjGc7WhI0nqc11QWtQ5EITdu
         UTM2KVSgFjySzQCNEJxU8a5PWqnvTl3pzTrWBW+V9Tg7RUuhaISvBXPc7a/Hvfsni78s
         dPqZ6Ndi9rzLFxMC6MclzvVLJRddmbckXfuvezTKb9Eqhe6OVshCnB/ijW2y5+mrphyU
         4h3Q==
X-Gm-Message-State: APjAAAVXqbbWWzlHEROTDp1hdTZEtxw+sZQTLkFD4UP7W15etKr3t1Wp
        ZdmbSC+xP7cLuesejNUr33AFB9qzO2H+3Tr7v1d82fXG8SeDAw==
X-Google-Smtp-Source: APXvYqzVGa5LUIhVMuui+o+RI/i9wmbCWtbHJP8VvIrQhQqYRdnV3kvMqtlz5b42TS3qyaKL0jasvxKv/r4GKYjRtqw=
X-Received: by 2002:a6b:f114:: with SMTP id e20mr17112641iog.169.1559758384021;
 Wed, 05 Jun 2019 11:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190604203859.181156-1-matthewgarrett@google.com> <1559691534.4278.14.camel@linux.ibm.com>
In-Reply-To: <1559691534.4278.14.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 5 Jun 2019 11:12:52 -0700
Message-ID: <CACdnJuvva4n5dDfoUhzZ9RAxzR=Wou4SuLfe8DCGp4f53cXM3w@mail.gmail.com>
Subject: Re: [PATCH V4] IMA: Allow profiles to define the desired IMA template
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        prakhar srivastava <prsriva02@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 4, 2019 at 4:39 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> Matthew, what is a "profile"?  Could we rename this patch to something
> clearer?  Maybe something like "support for per policy rule template
> formats"?

Sounds good to me. Could you also add an Inspired-By: Roberto Sassu
<roberto.sassu@huawei.com> ?
