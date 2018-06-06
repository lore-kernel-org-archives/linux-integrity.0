Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38042 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751920AbeFFOwl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Jun 2018 10:52:41 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w56EnK3Y026106
        for <linux-integrity@vger.kernel.org>; Wed, 6 Jun 2018 10:52:41 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jefb307w0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 06 Jun 2018 10:52:40 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 6 Jun 2018 15:52:39 +0100
Subject: Re: [PATCH v3 4/4] ima: Differentiate auditing policy rules from
 "audit" actions
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        sgrubb@redhat.com, linux-kernel@vger.kernel.org
Date: Wed, 06 Jun 2018 10:52:23 -0400
In-Reply-To: <CAHC9VhSbdYOkcszy+emgPNWWtUc0LoWy8pPvov+qjubV7b_EjQ@mail.gmail.com>
References: <20180604205455.2325754-1-stefanb@linux.vnet.ibm.com>
         <20180604205455.2325754-5-stefanb@linux.vnet.ibm.com>
         <CAHC9VhRkkQ74tvqGrSuNX2RdeHz5N7eU03-yHmVsZg47TxFD0g@mail.gmail.com>
         <1528208105.3237.155.camel@linux.vnet.ibm.com>
         <CAHC9VhSbdYOkcszy+emgPNWWtUc0LoWy8pPvov+qjubV7b_EjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1528296743.3255.29.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-06-05 at 18:18 -0400, Paul Moore wrote:
> On Tue, Jun 5, 2018 at 10:15 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > Hi Paul,
> >
> > On Mon, 2018-06-04 at 20:21 -0400, Paul Moore wrote:
> >> On Mon, Jun 4, 2018 at 4:54 PM, Stefan Berger
> >> <stefanb@linux.vnet.ibm.com> wrote:
> >> > The AUDIT_INTEGRITY_RULE is used for auditing IMA policy rules and
> >> > the IMA "audit" policy action.  This patch defines
> >> > AUDIT_INTEGRITY_POLICY_RULE to reflect the IMA policy rules.
> >> >
> >> > Since we defined a new message type we can now also pass the
> >> > audit_context and get an associated SYSCALL record. This now produces
> >> > the following records when parsing IMA policy's rules:
> >>
> >> Aaand now I see you included the current->audit_context pointer I
> >> mentioned in my comments for 3/4 ;)
> >>
> >> So basically this should be fine, although I should point out that you
> >> do not need to define a new message type to associate records
> >> together.  The fact that we don't associate all connected records is
> >> basically a bug.
> >>
> >> Anyway, patches 3/4 and 4/4 look good to me.  Considering this is
> >> likely going in during the *next* merge window, I would ask that you
> >> convert from "current->audit_context" to "audit_context()" as soon as
> >> this merge window closes.
> >>
> >> Thanks!
> >
> > Thanks, Paul.  I'd like to start queueing patches for the next open
> > window now, instead of scrambling later.  Can I add your Ack now, and
> > remember to make this change when rebasing?
> 
> Sure, go ahead and add my ACK to both 3/4 and 4/4 as long as you
> double pinky swear you'll do the audit_context() fix-up during the
> merge :)
> 
> Acked-by: Paul Moore <paul@paul-moore.com>

Sure, it will be really hard to miss.  The next-integrity-queued
branch has:

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

*** Remember replace current->audit_context with call to audit_context() ***
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
